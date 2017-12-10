//
//  Vote.swift
//  BitPredict
//
//  Created by eoin on 12/1/17.
//  Copyright © 2017 panna. All rights reserved.
//

import Foundation
import CoreData

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
    
    init(managedObject: NSManagedObject) {
        date = managedObject.value(forKey: "date") as? Date ?? Date(timeIntervalSince1970: TimeInterval(exactly: 1234567)!)
        switch managedObject.value(forKey: "pref") as! Int {
        case 0:
            sentiment = .UP
        case 1:
            sentiment = .DOWN
        case 2:
            sentiment = .NEUTRAL
        default:
            print("sentiment was wrong")
        }
    }

}
