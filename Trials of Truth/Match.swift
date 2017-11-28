//
//  Match.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/13/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Match: NSObject, NSCoding {


    init(matchNumber: Int) {
        self.matchNumber = matchNumber
    }
    
    var currentWraith: Wraith!
    
    var matchNumber: Int
    
    var matchTotalPoints: Int = 0
    
    var rounds: [Round] = [Round(),Round(),Round(),Round(),Round(),
                           Round(),Round(),Round(),Round(),Round()]
    
    var roundIndex: Int = 0
    
    var matchIsOver = false
    
    var currentRound: Round? {
        get {
            guard rounds.count > roundIndex else {
                return nil
            }
            
            return rounds[roundIndex]
        }
    }
        
    func calcAttackRate() -> Float {
        let totalRounds = Float(rounds.count)
        
        //get the number of times the player attacked
        var attacks: Float = 0.0
        
        for round in rounds {
            if round.userMove == .Attack {
                attacks += 1.0
            }
        }
        
        //calculate the average attack %
        
        let attackRate = attacks / totalRounds
        
        return attackRate
    }
    

    func encode(with aCoder: NSCoder) {
        aCoder.encode(matchIsOver, forKey: "matchIsOver")
        aCoder.encode(matchTotalPoints, forKey: "matchTotalPoints")
        aCoder.encode(rounds, forKey: "rounds")
        aCoder.encode(roundIndex, forKey: "roundIndex")
        aCoder.encode(matchNumber, forKey: "matchNumber")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        matchIsOver = aDecoder.decodeBool(forKey: "matchIsOver")
        matchTotalPoints = aDecoder.decodeInteger(forKey: "matchTotalPoints")
        matchNumber = aDecoder.decodeInteger(forKey: "matchNumber")
        if let savedRounds = aDecoder.decodeObject(forKey: "rounds") as? [Round] {
            rounds = savedRounds
        }
        roundIndex = aDecoder.decodeInteger(forKey: "roundIndex")
    }
    
    func setupWraith() {
        switch self.matchNumber {
            
        }
    }

}
