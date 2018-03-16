//
//  Match.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/13/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

let ROUND_COUNT = 10

class Match: NSObject, NSCoding {
    
    init(matchNumber: Int) {
        self.matchNumber = matchNumber
        rounds = []
        for _ in 0..<ROUND_COUNT {
            rounds.append(Round())
        }
        
        super.init()
        setupWraith()
    }
    
    var currentWraith: Wraith!
    
    var matchNumber: Int
    
    var matchTotalPoints: Int = 0
    
    var rounds: [Round]
    
    var roundIndex: Int = 0
    
    var matchIsOver = false
    
    var storyList = [
        StoryPage(message: "Select Attack or Guard.\n\nThe Wraith can attack with an energy slash or energy bust.\n\nAchieve a Power Level of 5 to defeat this Wraith.", image: nil),
        StoryPage(message: "Truth is a powerful weapon.\n\nThe sword's attack will beat the Wraith's energy slash, but it leaves the Knight vunerable to the Wraith's energy bust.\n\nAchieve a Power Level of 8 to defeat this the Wraith.", image: nil),
        StoryPage(message: "Use your guard to defect the Wraith's energy bust.\n\nAchieve a Power Level of 13 to advance to defeat this Wraith.", image: nil),
        StoryPage(message: "The final two Wraith's are much more powerful than the first three.\n\nAchieve a Power Level of 21 to advance to defeat this Wraith.", image: nil),
        StoryPage(message: "Select Attack or Guard.\n\nAchieve a Power Level of 34 to advance to defeat the final Wraith and complete your mission.", image: nil),
    ]
    
    
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
            if round.userMove == .Sword {
                attacks += 1.0
            }
        }
        
        //calculate the average attack %
        let attackRate = attacks / totalRounds
        
        return attackRate
    }
    
    func nextRound(userMove: Move) {
        guard let currentRound = currentRound else {
            return
        }
        
        currentRound.userMove = userMove
        currentRound.wraithMove = currentWraith.compMove(attackRate: calcAttackRate(), roundIndex: roundIndex).move
        
        //record the results - add to previous total score, record players move & calculate percent
        matchTotalPoints += currentRound.roundPoints
        
        roundIndex += 1
        
        //end the match
        if roundIndex == ROUND_COUNT {
            matchIsOver = true
        }
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
        rounds = aDecoder.decodeObject(forKey: "rounds") as! [Round]
        roundIndex = aDecoder.decodeInteger(forKey: "roundIndex")
        
        super.init()
        setupWraith()
    }
    
    func setupWraith() {
        switch self.matchNumber {
           
        case 1:
            currentWraith = Wraith()
        case 2:
            currentWraith = Wraith2()
        case 3:
            currentWraith = Wraith3()
        case 4:
            currentWraith = Wraith4()
        case 5:
            currentWraith = Wraith5()
            
        default: currentWraith = Wraith()
        }
    }

}
