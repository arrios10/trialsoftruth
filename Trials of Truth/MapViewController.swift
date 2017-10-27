//
//  MapViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/13/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var wraithOneButton: UIButton!
    @IBOutlet weak var wraithTwoButton: UIButton!
    @IBOutlet weak var wraithThreeButton: UIButton!
    @IBOutlet weak var wraithFourButton: UIButton!
    @IBOutlet weak var wraithFiveButton: UIButton!
    @IBOutlet weak var totalGameScore: UILabel!
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wraithTwoButton.isEnabled = false
        wraithThreeButton.isEnabled = false
        wraithFourButton.isEnabled = false
        wraithFiveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGame()
        
    }

    
    
    //method to update current game state whenever the map view appears
    
    func updateGame() {
    
        totalGameScore.text = "\(currentGame.gameTotalPoints)"
       
        if currentGame.matches.count == 1 && currentGame.matches[0].matchIsOver == true {
            wraithTwoButton.isEnabled = true
            currentGame.gameTotalPoints += currentGame.matches[0].matchTotalPoints
            totalGameScore.text = "\(currentGame.gameTotalPoints)"
            wraithOneButton.isEnabled = false
        }
        
        if currentGame.matches.count == 2 && currentGame.matches[1].matchIsOver == true {
            wraithThreeButton.isEnabled = true
            currentGame.gameTotalPoints += currentGame.matches[1].matchTotalPoints
            totalGameScore.text = "\(currentGame.gameTotalPoints)"
            wraithTwoButton.isEnabled = false
        }
        
        if currentGame.matches.count == 3 && currentGame.matches[2].matchIsOver == true {
            wraithFourButton.isEnabled = true
            currentGame.gameTotalPoints += currentGame.matches[2].matchTotalPoints
            totalGameScore.text = "\(currentGame.gameTotalPoints)"
            wraithThreeButton.isEnabled = false
        }
        
        if currentGame.matches.count == 4 && currentGame.matches[3].matchIsOver == true {
            wraithFiveButton.isEnabled = true
            currentGame.gameTotalPoints += currentGame.matches[3].matchTotalPoints
            totalGameScore.text = "\(currentGame.gameTotalPoints)"
            wraithFourButton.isEnabled = false
        }
        
        if currentGame.matches.count == 5 && currentGame.matches[4].matchIsOver == true {
            wraithFiveButton.isEnabled = false
            currentGame.gameTotalPoints += currentGame.matches[4].matchTotalPoints
            totalGameScore.text = "\(currentGame.gameTotalPoints)"
        }
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: currentGame)
        UserDefaults.standard.set(encodedData, forKey: "currentGame")
    }
    
    //enable/disable knight buttons
    
    //track progress through game in order from first knight to last knight
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? GameViewController
        
        let currentMatch = Match()
        nextController?.currentMatch = currentMatch
        currentGame.matches.append(currentMatch)
        
    }
    
   
    
}
