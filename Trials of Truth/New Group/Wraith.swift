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
            return ["Who dares enter our domain?", //1
                    "That sword.\nWe know that sword.\nYou are not worthy of that sword.", //4
                    "Press your attack or keep your guard, either way we will destory you.", //3
                    "Your thoughts betray you.\nYou seek the power of the Fire Pearl.\nA power you cannot possibly control.", //2
                    "Who is your master?", //5
                    "Ah.\nThe King in the West commands you.", //6
                    "If your king had honor his prince would stand before us now.\nInstead we get his pawn.", //7
                    "Your master pressed too far east.\nNow he is doomed by the war he started.", //8
                    "Now you will fall. The West will fall.", //9
                    "You cannot win. If your best us, we will diminish for a time. If we best you, you are gone forever." //10
            ]
            
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
