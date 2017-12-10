//
//  ViewController.swift
//  BitPredict
//
//  Created by eoin on 11/29/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var models: Models!
    
    let padding: CGFloat = 25.0
    var navHeight: CGFloat!
    
    var voteButton: UIButton!
    var resultsButton: UIButton!
    var pastPrefsButton: UIButton!
    
    var aboutLabel: UILabel!
    var aboutTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set defaults
        navHeight = (navigationController?.navigationBar.frame.maxY)!
        
        view.backgroundColor = .white
        title = "BitPredict"
        
        // layout the view
        voteButton = UIButton(type: .roundedRect)
        voteButton.frame = CGRect(x: 0, y: navHeight + padding, width: 10, height: 10)
        voteButton.setTitle(" Vote ", for: .normal)
        voteButton.backgroundColor = .lightGray
        voteButton.setTitleColor(.black, for: .normal)
        voteButton.titleLabel?.font = voteButton.titleLabel?.font.withSize(20)
        voteButton.sizeToFit()
        voteButton.center.x = view.center.x - 25
        view.addSubview(voteButton)
        
        resultsButton = UIButton(type: .roundedRect)
        resultsButton.setTitle(" Results ", for: .normal)
        resultsButton.backgroundColor = .lightGray
        resultsButton.setTitleColor(.black, for: .normal)
        resultsButton.titleLabel?.font = resultsButton.titleLabel?.font.withSize(20)
        resultsButton.sizeToFit()
        resultsButton.frame = CGRect(x: voteButton.frame.minX - (padding + resultsButton.frame.width), y: navHeight + padding, width: 10, height: 10)
        resultsButton.sizeToFit()
        view.addSubview(resultsButton)
        
        pastPrefsButton = UIButton(type: .roundedRect)
        pastPrefsButton.frame = CGRect(x: voteButton.frame.maxX + padding, y: navHeight + padding, width: 10, height: 10)
        pastPrefsButton.setTitle(" Past Prefrences ", for: .normal)
        pastPrefsButton.backgroundColor = .lightGray
        pastPrefsButton.setTitleColor(.black, for: .normal)
        pastPrefsButton.titleLabel?.font = pastPrefsButton.titleLabel?.font.withSize(20)
        pastPrefsButton.sizeToFit()
        view.addSubview(pastPrefsButton)
        
        aboutLabel = UILabel(frame: CGRect(x: padding * 3, y: voteButton.frame.maxY + padding, width: 10, height: 10))
        aboutLabel.text = "About"
        aboutLabel.font = aboutLabel.font.withSize(25)
        aboutLabel.sizeToFit()
        view.addSubview(aboutLabel)
        
        aboutTextView = UITextView(frame: CGRect(x: padding, y: aboutLabel.frame.maxY + (padding/2), width: view.frame.width - 2*padding, height: view.frame.maxY - (aboutLabel.frame.maxY + 1.5*padding)))
        aboutTextView.isEditable = false
        aboutTextView.text = restAPI.getAboutMessage()
        view.addSubview(aboutTextView)
        
        // add actions to the buttons
        voteButton.addTarget(self, action: #selector(voteButtonPressed), for: .touchUpInside)
        resultsButton.addTarget(self, action: #selector(resultsButtonPressed), for: .touchUpInside)
        pastPrefsButton.addTarget(self, action: #selector(pastPrefsButtonPressed), for: .touchUpInside)
    }

    // actions for buttons
    
    @objc func voteButtonPressed() {
        let vc: VoteViewController = VoteViewController()
        vc.models = models
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func resultsButtonPressed() {
        let vc: PreResultsViewController = PreResultsViewController()
        vc.models = models
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func pastPrefsButtonPressed() {
        let vc: PastPrefsViewController = PastPrefsViewController()
        vc.models = models
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

