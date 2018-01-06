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
    
    var gameState: GameState = GameState.Started {
        didSet {
            if gameState == .Win && gameTotalPoints > currentUser.highScore {
                currentUser.highScore = gameTotalPoints
            }
        }
    }
    
    let gameOverMessage = "game over"

    let gameWinnerMessage = "you win!"
    
    let gameIntro = "you are a knight on a quest"
    
    var introPresented = false
    
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
        aCoder.encode(introPresented, forKey: "introPresented")
    }

    required init?(coder aDecoder: NSCoder) {
        matchIndex = aDecoder.decodeInteger(forKey: "matchIndex")
        matches = aDecoder.decodeObject(forKey: "matches") as! [Match]
        introPresented = aDecoder.decodeBool(forKey: "introPresented")
    }

}
