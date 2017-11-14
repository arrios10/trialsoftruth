//
//  Round.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

enum Move: Int {
    case Attack, Yield
}

class Round: NSObject, NSCoding {
    /* need initializer, computer move, player move*, point awarded*/
    
    override init() {
    
    }
    
    var roundPoints: Int = 0
    
    var computerMove: Move?
    
    var playerMove: Move?
    
    func calcScore() -> Int {
        
        // AA 1
        // AY 3
        // YA 0
        // YY 2
        
        switch playerMove! {
        case Move.Attack:
            switch computerMove! {
            case Move.Attack:
                return 1
                
            case Move.Yield:
                return 3
            }
            
        case Move.Yield:
            switch computerMove! {
            case Move.Attack:
                return 0
                
            case Move.Yield:
                return 2
            }
            
        }
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(playerMove, forKey: "playerMove")
    }
    
    required init?(coder aDecoder: NSCoder) {
        playerMove = Move(rawValue: aDecoder.decodeInteger(forKey: "playerMove"))
    }
    

} 


    
