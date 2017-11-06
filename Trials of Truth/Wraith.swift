//
//  Wraith.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/30/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

struct RoundAction {
    var message: String!
    var move: Move!
}

class Wraith {
    
    var meanList: [String] = ["message a",
                                 "message b",
                                 "message c",
                                 "message d",
                                 "message e",
                                 "message f",
                                 "message g",
                                 "message h",
                                 "message i",
                                 "message j"]
    
    var niceList: [String] = ["message 1",
                              "message 2",
                              "message 3",
                              "message 4",
                              "message 5",
                              "message 6",
                              "message 7",
                              "message 8",
                              "message 9",
                              "message 10"]
    
    var listIndex = 0
    
    
    func compMove(attackRate: Float) -> RoundAction {
        // if below 20% or above 80%, ATTACK!, if attack rate is exactly 50% attack 25% of the time, otherwise, attack 20% of the time
        
        var action = RoundAction()
        
        if attackRate <= 0.2 || attackRate  >= 0.8 || attackRate == 0.5 {
            //print mode 2
            //maybe 80% "MEAN"
            //show the mean message
            action.message = meanList[listIndex]
            listIndex += 1
            print(listIndex)
            let randomNumber = arc4random() % 10
            if randomNumber <= 7 { //90% | mean mode
                action.move = .Attack
                return action
            }
        } else {
            //generate a random number between 0 and 4
            // send a nice message
            action.message = niceList[listIndex]
            listIndex += 1
            print(listIndex)
            let randomNumber = arc4random() % 5
            if randomNumber == 0 { //20% | nice mode
                action.move = .Attack
                return action
            }
        }


        action.move = .Yield
        return action
        
    }
    
    
}
