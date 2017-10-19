//
//  Match.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/13/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Match: NSObject, NSCoding {
    
    override init() {
    
    }
    
    var matchTotalPoints: Int = 0
    
    var rounds: [Round] = []
    
    var roundIndex: Int = 0
    
    var matchIsOver = false 
    
    func compMove() -> Move {
        
        //get the number of rounds played
        
        let totalRounds = Float(rounds.count)
        
        //get the number of times the player attacked
        var attacks: Float = 0.0
        
        for round in rounds {
            if round.playerMove == .Attack {
                attacks += 1.0
            }
        }
        
        //calculate the average attack %
        
        let attackRate = attacks / totalRounds
        
        // if below 20% or above 80%, ATTACK! otherwise, attack 20% of the time
        
        if attackRate <= 0.2 || attackRate  >= 0.8 {
            return Move.Attack
        }   else {
            //generate a random number between 0 and 4
            let randomNumber = arc4random() % 5
            
            if randomNumber == 0 {
                return Move.Attack
            }
            return Move.Yield
            
            
            // switch instead of if for attackRate test
            //        switch attackRate {
            //        case 0...0.2: break
            //        case 0.8...1: break
            //        default:
            //            break
            //        }
          
            
        }
    }
    
    

    func encode(with aCoder: NSCoder) {
    }
    
    required init?(coder aDecoder: NSCoder) {
    }
    

}
