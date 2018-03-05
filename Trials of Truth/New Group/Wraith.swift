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
            return "LEVEL I"
        }
    }
    
    var wraithImage: UIImage {
        get {
            return #imageLiteral(resourceName: "Wraith1")
        }
    }
    
    var primaryMessages: [String] = ["I sense your thoughts. You seek the magic stone. Unwise, but inevitable.",
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
    
      
    //    func compMove(userMove: Move, roundIndex: Int) -> RoundAction {

    func compMove(attackRate: Float, roundIndex: Int) -> RoundAction {
        
        var action = RoundAction()
        action.message = primaryMessages[roundIndex]

        let randomNumber = arc4random_uniform(2)
        if randomNumber == 0 {
               action.move = .Sword
               return action
           }

        action.move = .Shield
        return action
        
    }
    
    
}
