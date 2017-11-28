//
//  Game.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Game: NSObject, NSCoding /*, Encodable, Decodable*/  {
    
    override init() {
    }

    var matches: [Match] = [Match.init(matchNumber: 1),
                            Match.init(matchNumber: 2),
                            Match.init(matchNumber: 3),
                            Match.init(matchNumber: 4),
                            Match.init(matchNumber: 5)]
        
    var matchIndex = 0

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
        if let savedMatches = aDecoder.decodeObject(forKey: "matches") as? [Match] {
            matches = savedMatches
        }
        
    }
    
    
}
