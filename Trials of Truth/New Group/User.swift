//
//  User.swift
//  Trials of Truth
//
//  Created by Drew Rios on 12/14/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    

    
    var highScore: Int = 0
    
    var currentGame: Game!
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(highScore, forKey: "highScore")
        aCoder.encode(currentGame, forKey: "currentGame")
    }
    
    required init?(coder aDecoder: NSCoder) {
        highScore = aDecoder.decodeInteger(forKey: "highScore")
        currentGame = aDecoder.decodeObject(forKey: "currentGame") as? Game
    }
    
    override init() {
        super.init()
    }
    
    
    class func saveUser() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: currentUser)
        UserDefaults.standard.set(encodedData, forKey: "currentUser")
        
        UserDefaults.standard.synchronize()
    }
    
    class func loadUser() {
        if let data = UserDefaults.standard.data(forKey: "currentUser"), let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
            currentUser = user
        } else {
            currentUser = User()
        }
    }
    
    
    
    
    
}
