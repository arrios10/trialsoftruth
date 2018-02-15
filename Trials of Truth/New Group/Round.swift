//
//  Round.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

enum Move: Int {
    case Sword, Shield
}

class Round: NSObject, NSCoding {
    /* need initializer, computer move, player move*, point awarded*/
    
    override init() {}
    
    var roundPoints: Int {
        get {
            guard let userMove = userMove, let wraithMove = wraithMove else {
                return 0
            }
            
            
            switch userMove {
            case Move.Sword:
                switch wraithMove {
                case Move.Sword:
                    return 2
                    
                case Move.Shield:
                    return -1
                }
                
            case Move.Shield:
                switch wraithMove {
                case Move.Sword:
                    return 1
                    
                case Move.Shield:
                    return 0
                }
                
            }
        }
    }
    
    var wraithMove: Move?
    
    var userMove: Move?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userMove?.rawValue, forKey: "userMove")
        aCoder.encode(wraithMove?.rawValue, forKey: "wraithMove")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let value = aDecoder.decodeObject(forKey: "userMove") as? Int {
            userMove = Move(rawValue: value)
        }
        
        if let compValue = aDecoder.decodeObject(forKey: "wraithMove") as? Int {
            wraithMove = Move(rawValue: compValue)
        }
    }
    
}
