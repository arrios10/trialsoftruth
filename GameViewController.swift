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
        pointsAwardedLabel.text = ""
        foeActionLabel.text = ""
    }
    
    func playMatch(playerMove: Move) {
        //access the correct game and match
        let currentMatch = currentGame.matches[currentGame.matchIndex]
        
        //execute the match - get the computer's move, compare to the player's move
        currentMatch.playerMove = playerMove
        currentMatch.computerMove = currentGame.compMove()
        currentMatch.matchPoints = currentMatch.calcScore()
        
        //reward points
        pointsAwardedLabel.text = String(currentMatch.matchPoints)
        foeActionLabel.text = currentMatch.computerMove == .Attack ? "Your foe has attacked" : "Your foe has yielded"
        
        //record the results - add to previous total score, record players move & calculate percent
        currentGame.gameTotalPoints += currentMatch.matchPoints
        
        messageLabel.text = String(currentGame.gameTotalPoints)
    }

    @IBAction func attackButtonSelected(_ sender: Any) {
        playMatch(playerMove: Move.Attack)


    
    }
    
    @IBAction func yieldButtonSelected(_ sender: Any) {
        playMatch(playerMove: Move.Yield)
        
        
    }
    
   }

