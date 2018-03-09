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
    
    var primaryMessages: [String] = ["Who dares enter our domain?",
                                     "Your thoughts betray you. You seek Power Stones. Power you cannot possibly control.",
                                 "That sword. We know that sword. You are not worthy of that sword.",
                                 "You must choose your action wisely",
                                 "Who is your master?",
                                 "Ah. The King in the West commands you.",
                                 "If your king had honor his prince would stand before me now. Instead we get his pawn.",
                                 "This quest will be the end of you. But we welcome your sacrifice.",
                                 "Press your attack or guard yourself, either way we will defeat you.",
                                 "You cannot win. If your best us, we will diminish for a time. If we best you, you are gone forever."]
    
      
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
