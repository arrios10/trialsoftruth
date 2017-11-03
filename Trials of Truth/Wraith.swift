//
//  Wraith.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/30/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Wraith {

    //var wraithMessage: String
    
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
    
    
    
    
    func compMove(attackRate: Float) -> Move {
        // if below 20% or above 80%, ATTACK!, if attack rate is exactly 50% attack 25% of the time, otherwise, attack 20% of the time
        
        if attackRate <= 0.2 || attackRate  >= 0.8 || attackRate == 0.5 {
            //print mode 2
            //maybe 80% "MEAN"
            let randomNumber = arc4random() % 10
            if randomNumber <= 7 { //80%
             
            return Move.Attack
                
            }
            
            } else {
                //generate a random number between 0 and 4
                let randomNumber = arc4random() % 5
                if randomNumber == 0 { //20%
             
                return Move.Attack
                }
            }



        return Move.Yield
        
    }
    
    
}
