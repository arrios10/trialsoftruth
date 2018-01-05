//
//  Wraith2.swift
//  Trials of Truth
//
//  Created by Drew Rios on 1/4/18.
//  Copyright © 2018 Relativistic. All rights reserved.
//

import Foundation


class Wraith2: Wraith {
    
    
    //attack first no matter what, then act normal
    
    
    override func compMove(attackRate: Float, roundIndex: Int) -> RoundAction {
        if roundIndex == 0 {
            return RoundAction(message: primaryMessages[roundIndex], move: .Attack)
        }
        
        return super.compMove(attackRate: attackRate, roundIndex: roundIndex)
    }
    
}
