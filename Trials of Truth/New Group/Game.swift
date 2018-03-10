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
    
    let gameOverMessage = [
        StoryPage(message: "Eons ago an asteroid from deep space hit the planet. With it came five Wraiths from another world.\nMany ages later, two rival powers fought a great battle to control the caves where the Wraiths dwell. \n The battle raged for weeks, until nearly every soldier lay slain.",
                  image: nil),
    ]

    let gameWinnerMessage = [
                            StoryPage(message: "the knight of truth is on a dangerous quest", image: #imageLiteral(resourceName: "knight")),
                            StoryPage(message: "the knight of ", image: nil),
                            StoryPage(message: "dangerous quest", image: nil)
                            ]
    
    let gameIntroMessage = [
        StoryPage(message: "Eons ago an asteroid from deep space hit the planet. With it came five Wraiths from another world.\n\nMany ages later, two rival powers fought a great battle to control the caves where the Wraiths dwell.\n\nThe battle raged for weeks, until nearly every soldier lay slain.",
                  image: nil),
        StoryPage(message: "At great cost, the Western Kingdom seized the caves and sent a small force to take the Power Stones from the Wraiths that created them.",
                  image: nil),
        StoryPage(message: "To secure the stones, a single warrior will enter the caves and battle the Wraiths.\n\nThe warrior wields Truth, a mysterious and magical sword. The only weapon known to harm the Wraiths. ",
                  image: #imageLiteral(resourceName: "knight-1"))
    ]
    
    
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
