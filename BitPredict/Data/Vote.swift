//
//  Vote.swift
//  BitPredict
//
//  Created by eoin on 12/1/17.
//  Copyright © 2017 panna. All rights reserved.
//

import Foundation

enum Sentiment {
    case UP, DOWN, NEUTRAL
}

class Vote: NSObject {
    var sentiment: Sentiment!
    var date: Date!
    
    init (sentiment s: Sentiment, date d: Date) {
        sentiment = s
        date = d
    }

}
