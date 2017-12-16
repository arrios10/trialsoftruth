//
//  Game.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

let MATCH_COUNT = 5

enum GameState: Int {
    case Win, Lose, Started
}

class Game: NSObject, NSCoding /*, Encodable, Decodable*/  {
    
    override init() {
        matches = []
        for i in 1...MATCH_COUNT {
            matches.append(Match(matchNumber: i))
        }
    }
    
    var matches: [Match]
    
    var matchIndex = 0
    
    var gameState: GameState = GameState.Started
    
    let gameOverMessage = "game over"

    let gameWinnerMessage = "you win!"
    
    var currentMatch: Match? {
        get {
            guard matches.count > matchIndex else {
                return nil
            }
            
            return matches[matchIndex]
        }
    }
    
    var gameTotalPoints: Int {
        get {
            var total = 0
            for match in matches {
                total += match.matchTotalPoints
            }
            return total
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(matches, forKey: "matches")
        aCoder.encode(matchIndex, forKey: "matchIndex")
    }

    required init?(coder aDecoder: NSCoder) {
        matchIndex = aDecoder.decodeInteger(forKey: "matchIndex")
        matches = aDecoder.decodeObject(forKey: "matches") as! [Match]
    }

}
