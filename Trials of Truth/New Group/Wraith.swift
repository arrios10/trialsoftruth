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
    
    var primaryMessages: [String] {
        get {
            return ["Who dares enter our domain?",
                    "Your thoughts betray you.\nYou seek Power Stones.\nA power you cannot possibly control.",
                    "Press your attack or hold your guard, either way we will destory you.",
                    "That sword.\nWe know that sword.\nYou are not worthy of that sword.",
                    "Who is your master?",
                    "Ah.\nThe King in the West commands you.",
                    "If your king had honor his prince would stand before us now.\nInstead we get his pawn.",
                    "This quest will be the end of you.\nBut we welcome your sacrifice.",
                    "Choose your next move, but choose wisey.",
                    "You cannot win. If your best us, we will diminish for a time. If we best you, you are gone forever."]
            
        }
        
    }
      
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
