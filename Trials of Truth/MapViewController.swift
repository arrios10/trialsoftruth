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
    
    var currentGame: Game! = Game()
    
    
    
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
       
        if currentGame.matches.count >= 1 && currentGame.matches[0].matchIsOver == true {
            wraithTwoButton.isEnabled = true
        }
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
