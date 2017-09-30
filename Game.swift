//
//  Game.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Game: NSObject, NSCoding {
    /* need initializer, total points, results of each match, 
     which match youre currently in, 
     some way of saying the state to disk then recalling it, 
     method to return for attack percent */
    
    override init() {
        
    }

    var gameTotalPoints: Int = 0
    
    var matches: [Match] = []
    
    var matchIndex: Int = 0
    
    func compMove() -> Move {
        
       
        
        //get the number of matches played

        let totalMatches = Float(matches.count)
        
        //get the number of times the player attacked
        var attacks: Float = 0.0

        for match in matches {
            if match.playerMove == .Attack {
                attacks += 1.0
            }
        }
        
        //calculate the average attack %
        
        let attackRate = attacks / totalMatches
        
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
