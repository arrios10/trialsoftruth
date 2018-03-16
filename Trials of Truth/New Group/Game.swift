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
        StoryPage(message: "GAME OVER",
                  image: #imageLiteral(resourceName: "Wraithe_one_edit_2")),
    ]

    let gameWinnerMessage = [
                            StoryPage(message: "the knight of truth is on a dangerous quest", image: #imageLiteral(resourceName: "knight")),
                            StoryPage(message: "the knight of ", image: nil),
                            StoryPage(message: "dangerous quest", image: nil)
                            ]
    
    let gameIntroMessage = [
        StoryPage(message: "Eons ago an asteroid from deep space struck the earth.\n\nWith it came the five Wraiths.",
                  image: nil),
        StoryPage(message: "Ages later, two rival powers fought a fierce battle for control of the wraith-caves.\n\nAt great cost, the Western Kingdom found victory.",
                  image: nil ),
        StoryPage(message: "Within these caves lies the Fire Pearl.\n\nA weapon of unthinkable power.",
                  image: nil ),
        StoryPage(message: "A force of elite knights entered the caves to destroy the wraiths and seize the Fire Pearl.\n\nBut their swords met only thin air.\n\nAnd they fell to the wraiths.",
                  image: #imageLiteral(resourceName: "Necro_Wraith") ),
        StoryPage(message: "With little hope left, the Kingdom's greatest knight set out alone to battle the wraiths and save the kingdom.\n\nThis warrior wields Truth, an ancient and mysterious sword...\n",
                  image: #imageLiteral(resourceName: "hooded_knight_sword_update_no_sword"))
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
