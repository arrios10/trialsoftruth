//
//  Match.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Match: NSObject, NSCoding {
    /* need initializer, computer move, player move*, point awarded*/
    
    override init() {
    
    }
    
    var matchPoints: Int = 0
    
    var computerMove: String = ""
    
    var playerMove: String = ""
    
    
    func encode(with aCoder: NSCoder) {
    }
    
    required init?(coder aDecoder: NSCoder) {
    }
    

} 


    
