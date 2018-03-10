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
            return ["Who dares enter our domain?", //1
                    "Your thoughts betray you. You seek Power Stones. Power you cannot possibly control.", //2
                    "Press your attack or guard yourself, either way we will defeat you.",//3
                    "That sword. We know that sword. You are not worthy of that sword.",//4
                    "Who is your master?",//5
                    "Ah. The King in the West commands you.",//6
                    "If your king had honor his prince would stand before us now. Instead we get his pawn.",//7
                    "Your ancestor Vega had honor. Where is your honor?",//8
                    "You cannot win. If your best us, we will diminish for a time. If we best you, you are gone forever.",//9
                    "Still you fight. So be it./nWe welcome your sacrifice."]//10
            
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
