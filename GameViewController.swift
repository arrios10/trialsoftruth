//
//  GameViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var foeActionLabel: UILabel!
    
    @IBOutlet weak var pointsAwardedLabel: UILabel!
    
    var currentGame: Game! = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func playMatch(playerMove: String) {
        //access the correct game and match
        var currentMatch = currentGame.matches[currentGame.matchIndex]
        
        //execute the match - get the computer's move, compare to the player's move
        currentMatch.playerMove = playerMove
        
        
        //reward points
        
        //record the results - add to previous total score, record players move & calculate percent
    }

    @IBAction func attackButtonSelected(_ sender: Any) {
        playMatch(playerMove: "Attack")

    
    }
    
    @IBAction func yieldButtonSelected(_ sender: Any) {
        playMatch(playerMove: "Yield")
        
        
    }
    
   }

