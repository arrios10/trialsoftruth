//
//  Wraith.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/30/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Wraith {

    
    var attackMode: String = ""
    
    func compMove(attackRate: Float) -> Move {
        
    
        
        
        // if below 20% or above 80%, ATTACK!, if attack rate is exactly 50% attack 25% of the time, otherwise, attack 20% of the time
        
        if attackRate == 0.5 {
            let randomNumber = arc4random() % 4
            if randomNumber == 0 {
                
                return Move.Attack
            }
        } else if attackRate <= 0.2 || attackRate  >= 0.8 {
            
            return Move.Attack
        }   else {
            //generate a random number between 0 and 4
            let randomNumber = arc4random() % 5
            if randomNumber == 0 {
                
                return Move.Attack
            }
            
            
        }
        
        return Move.Yield
        
    }
    
    
}
