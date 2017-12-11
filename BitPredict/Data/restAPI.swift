//
//  restAPI.swift
//  BitPredict
//
//  Created by eoin on 11/30/17.
//  Copyright © 2017 panna. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Charts
import CoreData

class restAPI: NSObject {
    
    static func sendandSaveVote(_ vote: Vote, models: Models) {
        
        // Sending Vote
        var urlString: String = "http://bitcoinsentiment.com/index.php?api=1&a=vsp&c=408516840&s=btcusd&v="
        switch vote.sentiment {
            case .UP:
                urlString.append("1")
            case .NEUTRAL:
                urlString.append("0")
            case .DOWN:
                urlString.append("-1")
            case .none:
                print("what1")
            case .some(_):
                print("what2")
        }
        let url: URL = URL(string: urlString)!
        Alamofire.request(url)
        
        // Saving vote
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "VoteData", in: managedContext)!
        
        let calandar = Calendar.current
        let today = calandar.component(.day, from: vote.date)
        var lastDay: Int? = -1
        if (models.votesData.count > 0) {
            lastDay = calandar.component(.day, from: (models.votesData.last?.value(forKey: "date") as! Date))
        }
        
        if (lastDay != today) {
            let v = NSManagedObject(entity: entity, insertInto: managedContext)
            v.setValue(vote.date, forKey: "date")
            v.setValue(vote.sentiment.hashValue, forKey: "pref")
            do {
                try managedContext.save()
                models.votesData.append(v)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        else {
            models.votesData.last?.setValue(vote.sentiment.hashValue, forKey: "pref")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
            
    }
    
    static func getData(startDate: Date, endDate: Date, completion: @escaping ([JSON]) -> Void) {
        //print(startDate.timeIntervalSince1970.magnitude, endDate.timeIntervalSince1970.magnitude)
        let s: String = String(Int(startDate.timeIntervalSince1970.magnitude * 1000))
        let e: String = String(Int(endDate.timeIntervalSince1970.magnitude * 1000))
  
        
        let url = URL(string: "http://bitcoinsentiment.com/index.php?api=1&a=spj&s=btcusd&p=d&b=" + s + "&e=" + e)!
        print("requesting ", url)
 
         Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json.arrayValue
                print("\tnumber of items recieved: ", jsonArray.count)
                print("sent start: ", s, "\tsent end: ", e)
                //print(" got start: ", jsonArray.first?.arrayValue.first?.intValue, "\t got end: ", jsonArray.last?.arrayValue.first?.intValue)
                completion(jsonArray)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getAboutMessage() -> String {
        return """
        BitCoin is currently as as hot! as ever, so use BitPredict (TM) to help you predict the market and cash in.
        
        Navagate to the Vote tab to weigh in on what you think BitCoin will do in the next six months. Then, move over to the Past Prefrences tab to see a record of your past thoughts about the future of BitCoin. Keep in mind that you can only vote once per day, so if you vote multiple times we will just overwrite your previous vote!
        
        Next, navagate to the Results tab to unlock the collective knowledge of BitPredict users! View past data on the group opinion of bitcoin as a graph, or look at data for a specific day!
        
        Donate a few BitCoins to the BitPredict team when it helps you get rich!
        """
    }
    
}
