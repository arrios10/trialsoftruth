//
//  Wraith.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/30/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation
import UIKit

struct RoundAction {
    var message: String!
    var move: Move!
}

class Wraith {
    
    var wraithName: String {
        get {
            return "Wraith Name"
        }
    }
    
    var wraithImage: UIImage {
        get {
            return #imageLiteral(resourceName: "wraith0")
        }
    }
    
    var primaryMessages: [String] = ["message a",
                                 "message b",
                                 "message c",
                                 "message d",
                                 "message e",
                                 "message f",
                                 "message g",
                                 "message h",
                                 "message i",
                                 "message j"]
    
    var secondaryMessages: [String] = ["message 1",
                              "message 2",
                              "message 3",
                              "message 4",
                              "message 5",
                              "message 6",
                              "message 7",
                              "message 8",
                              "message 9",
                              "message 10"]
    
      
    
    func compMove(attackRate: Float, roundIndex: Int) -> RoundAction {
        // if below 20% or above 80%, ATTACK!, if attack rate is exactly 50% attack 25% of the time, otherwise, attack 20% of the time
        
        var action = RoundAction()
        
        if attackRate <= 0.1 || attackRate  >= 0.9 || attackRate == 0.5 {
      
            //show the mean message
            action.message = primaryMessages[roundIndex]
   
            let randomNumber = arc4random() % 10
            if randomNumber <= 9 { //90% | mean mode
                action.move = .Attack
                return action
            }
        } else {

            // send a nice message
            action.message = secondaryMessages[roundIndex]
   
            let randomNumber = arc4random() % 4
            if randomNumber == 0 { //25% | nice mode
                action.move = .Attack
                return action
            }
        }


        action.move = .Yield
        return action
        
    }
    
    
}
