//
//  PastPrefCollectionViewCell.swift
//  BitPredict
//
//  Created by eoin on 12/4/17.
//  Copyright © 2017 panna. All rights reserved.
//

import UIKit

class PastPrefCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel!
    var initalized: Bool = false
    
    func setUpWithVote(_ vote: Vote) {
        if initalized {
            label.removeFromSuperview()
        }
        label = UILabel(frame: frame)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        label.text = "  " + formatter.string(from: vote.date) + " — "
        switch vote.sentiment {
            case .UP:
                backgroundColor = .green
                label.text?.append("Will go up.")
            case .NEUTRAL:
                backgroundColor = .lightGray
                label.text?.append("Will stay the same.")
            case .DOWN:
                backgroundColor = .red
                label.text?.append("Will go down.")
            case .none:
                backgroundColor = .black
            case .some(_):
                backgroundColor = .black
        }
        label.font = label.font.withSize(18)
        backgroundView = label
        initalized = true
    }
    
    
}
