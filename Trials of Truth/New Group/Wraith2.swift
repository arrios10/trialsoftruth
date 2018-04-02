//
//  Wraith2.swift
//  Trials of Truth
//
//  Created by Drew Rios on 1/4/18.
//  Copyright © 2018 Relativistic. All rights reserved.
//

import UIKit


class Wraith2: Wraith {
    
    override var wraithName: String {
        get {
            return "LEVEL II"
        }
    }

    override var wraithImage: UIImage {
        get {
            return #imageLiteral(resourceName: "Wraith5")
        }
    }
    
    override var primaryMessages: [String] {
        get {
            return ["You cannot overcome us.\nA raindrop cannot overcome the sea.", //1
                    "That sword was not forged for your hands.", //2
                    "You must choose your action, but choose wisely.\nYour fate hangs in the balance.",//3
                    "Why do follow a foolish leader.\nIs it glory your seek?",//5
                    "Your thirst for greatness diminishes you.",//4
                    "Your ancestor Vega was known to us. He had honor.\nWhere is your honor?",//6
                    "Your weapon is strong, but your mind is weak.",//7
                    "How you hope to overcome us, when you cannot overcome yourself. ",//8
                    "We come from another world yet we know your kind better than you know yourselves.",//9
                    "Still you fight. So be it.\nWe welcome your sacrifice."]//10
            
        }
    }
    
    //attack first no matter what, then act normal
    
    
    override func compMove(attackRate: Float, roundIndex: Int) -> RoundAction {
        if roundIndex == 0 {
            return RoundAction(message: primaryMessages[roundIndex], move: .Sword)
        }
        
        return super.compMove(attackRate: attackRate, roundIndex: roundIndex)
                
        
    }
    
}
