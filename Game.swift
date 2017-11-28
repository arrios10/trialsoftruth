//
//  Game.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class Game: NSObject, NSCoding /*, Encodable, Decodable*/  {
    /* need initializer, total points, results of each round,
     which round youre currently in, 
     some way of saying the state to disk then recalling it, 
     method to return for attack percent */
//    enum CodingKeys: String, CodingKey {
//        case gameTotalPoints
//    }
    
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
    
    var gameTotalPoints = 0
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(gameTotalPoints, forKey: "gameTotalPoints")
        aCoder.encode(matches, forKey: "matches")
        aCoder.encode(matchIndex, forKey: "matchIndex")
    }

    required init?(coder aDecoder: NSCoder) {
        gameTotalPoints = aDecoder.decodeInteger(forKey: "gameTotalPoints")
        matchIndex = aDecoder.decodeInteger(forKey: "matchIndex")
        if let savedMatches = aDecoder.decodeObject(forKey: "matches") as? [Match] {
            matches = savedMatches
        }
        
    }
    
    
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(gameTotalPoints, forKey: .gameTotalPoints)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        gameTotalPoints = try values.decode(Int.self, forKey: .gameTotalPoints)
//
//    }
    
}
