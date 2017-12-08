//
//  PreResultsViewController.swift
//  BitPredict
//
//  Created by eoin on 12/8/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit

class PreResultsViewController: UIViewController {

    var models: Models!
    
    let padding: CGFloat = 25.0
    var navHeight: CGFloat!
    
    var startDatePicker: UIDatePicker!
    var endDatePicker: UIDatePicker!
    var startLabel: UILabel!
    var endLabel: UILabel!
    var todayButton: UIButton!
    var resultsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set defaults
        navHeight = (navigationController?.navigationBar.frame.maxY)!
        
        title = "Filter Results"

        // layout the view
        startLabel = UILabel(frame: CGRect(x: padding, y: padding + navHeight, width: 10, height: 10))
        startLabel.text = "Start date: "
        startLabel.sizeToFit()
        view.addSubview(startLabel)
        
        startDatePicker = UIDatePicker(frame: CGRect(x: padding, y: padding + startLabel.frame.maxY, width: view.frame.width - (2*padding), height: 150))
        startDatePicker.datePickerMode = .date
        let minDate: Date = Date(timeIntervalSince1970: TimeInterval(exactly: 1352500000)!)
        startDatePicker.setDate(minDate, animated: true)
        startDatePicker.minimumDate = minDate
        view.addSubview(startDatePicker)
        
        endLabel = UILabel(frame: CGRect(x: padding, y: 3*padding + startDatePicker.frame.maxY, width: 10, height: 10))
        endLabel.text = "End date: "
        endLabel.sizeToFit()
        view.addSubview(endLabel)
        
        todayButton = UIButton(type: .roundedRect)
        todayButton.setTitle(" Today ", for: .normal)
        todayButton.titleLabel?.font = todayButton.titleLabel?.font.withSize(18)
        todayButton.sizeToFit()
        todayButton.frame = CGRect(x: view.frame.width - (padding + todayButton.frame.width), y: endLabel.frame.minY, width: todayButton.frame.width, height: todayButton.frame.height)
        todayButton.addTarget(self, action: #selector(todayButtonPressed), for: .touchUpInside)
        view.addSubview(todayButton)
        
        endDatePicker = UIDatePicker(frame: CGRect(x: padding, y: padding + endLabel.frame.maxY, width: view.frame.width - (2*padding), height: 150))
        endDatePicker.datePickerMode = .date
        endDatePicker.setDate(Date(timeIntervalSince1970: TimeInterval(exactly: 1370728018)!), animated: true)
        endDatePicker.maximumDate = Date()
        view.addSubview(endDatePicker)
        
        resultsButton = UIButton(type: .roundedRect)
        resultsButton.frame = CGRect(x: 10, y: endDatePicker.frame.maxY + padding, width: 10, height: 10)
        resultsButton.setTitle(" See results ", for: .normal)
        resultsButton.titleLabel?.font = resultsButton.titleLabel?.font.withSize(18)
        resultsButton.sizeToFit()
        resultsButton.center.x = view.center.x
        resultsButton.addTarget(self, action: #selector(resultsButtonPressed), for: .touchUpInside)
        view.addSubview(resultsButton)
        
        
    }

    
    // define button actions
    
    @objc func resultsButtonPressed() {
        let vc: ResultsViewController = ResultsViewController()
        vc.models = models
        vc.startDate = startDatePicker.date
        vc.endDate = endDatePicker.date
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func todayButtonPressed() {
        endDatePicker.setDate(Date(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
