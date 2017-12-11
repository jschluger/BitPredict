//
//  OneResultViewController.swift
//  BitPredict
//
//  Created by eoin on 12/11/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit
import SwiftyJSON

class OneResultViewController: UIViewController {
    
    let padding: CGFloat = 25.0
    let secondsInDay: Double = 86400
    
    var navHeight: CGFloat!
    
    var date: Date!
    
    var nextButton: UIButton!
    var previousButton: UIButton!
    var dateLabel: UILabel!
    var upLabel: UILabel!
    var neutralLabel: UILabel!
    var downLabel: UILabel!
    var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set defaults
        navHeight = (navigationController?.navigationBar.frame.maxY)!
        
        // layout the view
        previousButton = UIButton(type: .roundedRect)
        previousButton.frame = CGRect(x: padding, y: padding + navHeight, width: 10, height: 10)
        previousButton.setTitle(" < Previous ", for: .normal)
        previousButton.sizeToFit()
        previousButton.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)
        view.addSubview(previousButton)
        
        nextButton = UIButton(type: .roundedRect)
        nextButton.setTitle(" Next > ", for: .normal)
        nextButton.sizeToFit()
        nextButton.frame = CGRect(x: view.frame.width - (nextButton.frame.width + padding), y: padding + navHeight, width: nextButton.frame.width, height: nextButton.frame.height)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        view.addSubview(nextButton)
        
        dateLabel = UILabel(frame: CGRect(x: 1, y: nextButton.frame.maxY + padding, width: 1, height: 1))
        view.addSubview(dateLabel)
        
        upLabel = UILabel(frame: CGRect(x: padding, y: dateLabel.frame.maxY + 3*padding, width: 1, height: 1))
        view.addSubview(upLabel)
        upLabel.textColor = .green
        
        neutralLabel = UILabel(frame: CGRect(x: padding, y: upLabel.frame.maxY + padding, width: 1, height: 1))
        view.addSubview(neutralLabel)
        neutralLabel.textColor = .lightGray
        
        downLabel = UILabel(frame: CGRect(x: padding, y: neutralLabel.frame.maxY + padding, width: 1, height: 1))
        view.addSubview(downLabel)
        downLabel.textColor = .red

        totalLabel = UILabel(frame: CGRect(x: padding, y: downLabel.frame.maxY + padding, width: 1, height: 1))
        view.addSubview(totalLabel)

        
        
        fillData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dateLabel.text = formatter.string(from: date)
        dateLabel.sizeToFit()
        dateLabel.center.x = view.center.x
        
        restAPI.getData(startDate: Date(timeIntervalSince1970: TimeInterval(0)), endDate: date) { data in
            let dataPoint: [JSON] = data.last!.arrayValue
            print(dataPoint[0], dataPoint[1], dataPoint[2], dataPoint[3] )
            let total: Double = dataPoint[1].doubleValue + dataPoint[2].doubleValue + dataPoint[3].doubleValue
            self.totalLabel.text = "\(NSString(format:"%.0f", total)) people voted in total."
            self.totalLabel.sizeToFit()
            
            self.upLabel.text = "\(NSString(format:"%.2f", 100 * dataPoint[1].doubleValue / total))% voted Up"
            self.upLabel.sizeToFit()

            self.neutralLabel.text = "\(NSString(format:"%.2f", 100 * dataPoint[2].doubleValue / total))% voted Neutral"
            self.neutralLabel.sizeToFit()

            self.downLabel.text = "\(NSString(format:"%.2f", 100 * dataPoint[3].doubleValue / total))% voted Down"
            self.downLabel.sizeToFit()
        }
        
        
    }
    
    
    // define button actions
    
    @objc func nextButtonPressed() {
        date = Date(timeInterval: TimeInterval(floatLiteral: secondsInDay), since: date)
        fillData()
    }

    @objc func previousButtonPressed() {
        date = Date(timeInterval: TimeInterval(floatLiteral: -1*secondsInDay), since: date)
        fillData()
    }

}






