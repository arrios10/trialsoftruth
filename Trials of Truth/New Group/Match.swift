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
    
    var storyList: [String] = [
        "The knight has entered the wraith cave and stands before the first wraith. Attacking with the sword will give you the most power, but leaves you open to their enery bursts. You can also use your shield to repel their enery burst. Get to a power level of 3 to defeat this wraith.",
        "Get to a power level of 5 to advance to the next wraith.",
        "3 - When Mr. Bilbo Baggins of Bag End announced that he would shortly be celebrating his eleventy-first birthday with a party of special magnificence, there was much talk and excitement in Hobbiton.",
        "4 - When Mr. Bilbo Baggins of Bag End announced that he would shortly be celebrating his eleventy-first birthday with a party of special magnificence, there was much talk and excitement in Hobbiton.",
        "5 - When Mr. Bilbo Baggins of Bag End announced that he would shortly be celebrating his eleventy-first birthday with a party of special magnificence, there was much talk and excitement in Hobbiton."
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
