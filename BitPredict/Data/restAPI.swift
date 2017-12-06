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

class restAPI: NSObject {
    
    static func sendVote(_ vote: Vote) {
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
    }
    
    static func getData() {
        let url = URL(string: "http://bitcoinsentiment.com/index.php?api=1&a=spj&s=btcusd&p=d&b=0&e=9999999999999")!
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                let jsonArray = json.arrayValue
                print(jsonArray.last!.arrayValue[1], " voted up today")
                print(jsonArray.last!.arrayValue[2], " voted neutral today")
                print(jsonArray.last!.arrayValue[3], " voted down today")
                print("-------------------")
                

            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getAboutMessage() -> String {
        return """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam convallis interdum nunc, quis luctus dolor molestie quis. Etiam sapien elit, auctor tincidunt quam sit amet, porta iaculis leo. Curabitur ultrices, ex porta dapibus tincidunt, augue mauris pharetra eros, sed rhoncus eros orci non diam. Nullam molestie eget lorem ut facilisis. Mauris non est id justo dignissim cursus eu vitae enim. Nulla id dui elementum, accumsan quam sed, semper eros. Integer a convallis erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus eu leo dignissim ante maximus rhoncus. Suspendisse at pulvinar enim. Integer massa lorem, tincidunt eu euismod nec, vestibulum id dolor. Morbi quis maximus ante. Phasellus et orci tincidunt tellus hendrerit congue. Nulla eget pharetra diam. In in accumsan urna. Aenean convallis sem sed venenatis sagittis.
        
        Aliquam eu ex eu mi gravida tincidunt. Morbi elementum auctor consectetur. Integer metus libero, vehicula nec efficitur egestas, venenatis vitae odio. Duis non ex non est auctor dapibus at nec orci. Vestibulum tincidunt sit amet tellus eu imperdiet. Nulla facilisi. Pellentesque porttitor tristique magna, efficitur venenatis mi hendrerit eget. Curabitur ultricies sodales eros vitae congue. Curabitur luctus ex sapien, nec tristique mauris laoreet ut. Nullam consectetur ultrices nulla at egestas. Donec tempus augue nulla, vel venenatis quam consequat eget. Ut sodales metus eu dolor volutpat iaculis. Sed vel turpis ex. Phasellus ut nunc ut tortor consectetur blandit quis eu felis. Vivamus consectetur pretium eros vitae ultrices.
        
        Morbi tempus quam mauris, at facilisis tortor volutpat in. Proin volutpat mauris sit amet fringilla ornare. Fusce vel ultrices nulla. Sed sagittis velit magna, eget placerat velit volutpat sit amet. Vestibulum sed ex euismod, feugiat arcu sed, rhoncus dolor. Fusce laoreet commodo tortor, eu mattis eros ornare quis. Phasellus volutpat urna et consectetur mattis.
        
        Duis non lorem ante. Nam tempus nulla ac ullamcorper semper. Donec fermentum ex et libero tincidunt, a sollicitudin nunc efficitur. Ut consectetur a nisi id vulputate. Etiam ut efficitur lectus, at egestas elit. Sed vel sem velit. Fusce laoreet, urna eu pulvinar luctus, sapien massa lobortis purus, eget tristique elit purus sit amet mauris. Praesent ac tortor ex. Maecenas dapibus sapien mauris, eu fermentum dui semper sit amet. Maecenas congue auctor dapibus. Nullam porttitor orci erat, et faucibus turpis accumsan non. Etiam in lacinia metus. Nullam sagittis ante magna, non bibendum nulla hendrerit ut.
        """
    }
    
}
