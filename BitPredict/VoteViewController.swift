//
//  VoteViewController.swift
//  BitPredict
//
//  Created by eoin on 11/30/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit
import CoreData

class VoteViewController: UIViewController {

    var models: Models!
    
    let padding: CGFloat! = 25
    var navHeight: CGFloat!
    
    var titleTextView: UITextView!
    var upButton: UIButton!
    var neutralButton: UIButton!
    var downButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set constants
        navHeight = (navigationController?.navigationBar.frame.maxY)!
       
        title = "Vote"
        
        // layout the view
        titleTextView = UITextView(frame: CGRect(x: padding, y: navHeight + padding, width: view.frame.width - (2*padding), height: 60))
        titleTextView.text = "The price of one Bitcoin (in USD) 6 months from today will..."
        titleTextView.font = titleTextView.font?.withSize(20)
        titleTextView.isEditable = false
        //titleTextView.isScrollEnabled = false
        view.addSubview(titleTextView)
        
        neutralButton = UIButton(type: .roundedRect)
        neutralButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        neutralButton.setTitle(" Stay The Same ", for: .normal)
        neutralButton.backgroundColor = .lightGray
        neutralButton.setTitleColor(.black, for: .normal)
        neutralButton.titleLabel?.font = neutralButton.titleLabel?.font.withSize(40)
        neutralButton.sizeToFit()
        neutralButton.center = view.center
        view.addSubview(neutralButton)
        
        upButton = UIButton(type: .roundedRect)
        upButton.setTitle(" Go Up ", for: .normal)
        upButton.backgroundColor = .green
        upButton.setTitleColor(.black, for: .normal)
        upButton.titleLabel?.font = upButton.titleLabel?.font.withSize(40)
        upButton.frame = CGRect(x: 0, y: neutralButton.frame.minY - (neutralButton.frame.height + padding), width: neutralButton.frame.width, height: neutralButton.frame.height)
        upButton.center.x = view.center.x
        view.addSubview(upButton)
        
        downButton = UIButton(type: .roundedRect)
        downButton.frame = CGRect(x: 0, y: neutralButton.frame.maxY + padding, width: neutralButton.frame.width, height: neutralButton.frame.height)
        downButton.setTitle(" Go Down ", for: .normal)
        downButton.backgroundColor = .red
        downButton.setTitleColor(.black, for: .normal)
        downButton.titleLabel?.font = downButton.titleLabel?.font.withSize(40)
        downButton.center.x = view.center.x
        view.addSubview(downButton)
    
        // add actions to the buttons
        neutralButton.addTarget(self, action: #selector(neutralButtonPressed), for: .touchUpInside)
        upButton.addTarget(self, action: #selector(upButtonPressed), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(downButtonPressed), for: .touchUpInside)
    }

    // define actions for pressing buttons
    @objc func neutralButtonPressed() {
        let date: Date = Date()
        let vote: Vote = Vote(sentiment: .NEUTRAL, date: date)
        restAPI.sendandSaveVote(vote, models: models)
    }
    
    @objc func upButtonPressed() {
        
        
        let date: Date = Date()
        let vote: Vote = Vote(sentiment: .UP, date: date)
        restAPI.sendandSaveVote(vote, models: models)
    }
    
    @objc func downButtonPressed() {
        let date: Date = Date()
        let vote: Vote = Vote(sentiment: .DOWN, date: date)
        restAPI.sendandSaveVote(vote, models: models)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
