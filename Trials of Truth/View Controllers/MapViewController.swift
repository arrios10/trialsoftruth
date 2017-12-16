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
    
    //method to update current game state whenever the map view
    func updateGame() {
    
        totalGameScore.text = "\(currentUser.currentGame.gameTotalPoints)"
       
        if currentUser.currentGame.matches[0].matchIsOver == true {
            currentUser.currentGame.matchIndex = 1
            wraithTwoButton.isEnabled = true
            wraithOneButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[1].matchIsOver == true {
            currentUser.currentGame.matchIndex = 2
            wraithThreeButton.isEnabled = true
            wraithTwoButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[2].matchIsOver == true {
            currentUser.currentGame.matchIndex = 3
            wraithFourButton.isEnabled = true
            wraithThreeButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[3].matchIsOver == true {
            currentUser.currentGame.matchIndex = 4
            wraithFiveButton.isEnabled = true
            wraithFourButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[4].matchIsOver == true {
            currentUser.currentGame.matchIndex = 5
            wraithFiveButton.isEnabled = false
        }
        
        User.saveUser()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? GameViewController
        
        nextController?.currentMatch = currentUser.currentGame.currentMatch
    }
    
}
