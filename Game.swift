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
    
    func encode(with aCoder: NSCoder) {
    }
    
    required init?(coder aDecoder: NSCoder) {
    }
    
    
}