//
//  MeanHelloWraith.swift
//  Trials of Truth
//
//  Created by Drew Rios on 11/6/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class MeanHelloWraith: Wraith {
    
//    override var meanList: [String] = []
    
    
    //attack first no matter what, then act normal
    
   
    
    override func compMove(attackRate: Float, roundIndex: Int) -> RoundAction {
        if roundIndex == 0 {
            return RoundAction(message: meanList[roundIndex], move: .Attack)
        }
        
        return super.compMove(attackRate: attackRate, roundIndex: roundIndex)
    }
    
}
