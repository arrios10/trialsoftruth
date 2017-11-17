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
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var foeActionLabel: UILabel!
    
    @IBOutlet weak var pointsAwardedLabel: UILabel!
    
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var yieldButton: UIButton!
    
    var currentMatch: Match!
    var compAction: RoundAction!
    
    // REFACTOR (for your consideration):
    // - Single function in charge of updating the display (showing game state)
    // - Single function responsible for handling the player's choice and adding a new round
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foeActionLabel.text = ""
    
        scoreLabel.text = String(currentMatch.matchTotalPoints)
        
        setupRound()
        
        print("current match:\(currentGame.matchIndex)")
    }
    
    func setupRound() {
        //calculate attack rate
        if currentMatch.rounds.count < 10 {
            let attackRate = currentMatch.calcAttackRate()
            compAction = currentMatch.currentWraith.compMove(attackRate: attackRate, roundIndex: currentMatch.roundIndex)
        }
        messageLabel.text = compAction.message
        print("current round:\(currentMatch.roundIndex)")
       
    }
    
    func playRound(playerMove: Move) {

        
        //create the round
        let currentRound = Round()
        
        //add the round to the round array in the Match object
        currentMatch.rounds.append(currentRound)
        
        currentMatch.roundIndex = currentMatch.rounds.count - 1
        
        currentRound.playerMove = playerMove
        currentRound.computerMove = compAction.move
        
        currentRound.roundPoints = currentRound.calcScore()
        
        pointsAwardedLabel.text = String(currentRound.roundPoints)
        
        //reward points
        foeActionLabel.text = currentRound.computerMove == .Attack ? "Your foe has attacked" : "Your foe has yielded"
        
        //record the results - add to previous total score, record players move & calculate percent
        currentMatch.matchTotalPoints += currentRound.roundPoints
        
        scoreLabel.text = String(currentMatch.matchTotalPoints)
        
        
        
        //end the game
        if currentMatch.rounds.count == 10 {
            messageLabel.text = "Game Over"
            attackButton.isEnabled = false
            yieldButton.isEnabled  = false
            currentMatch.matchIsOver = true
            currentGame.matchIndex += 1
            currentGame.gameTotalPoints += currentMatch.matchTotalPoints
            
        }
        
        setupRound()
    }

    @IBAction func attackButtonSelected(_ sender: Any) {
        playRound(playerMove: Move.Attack)
    }
    
    @IBAction func yieldButtonSelected(_ sender: Any) {
        playRound(playerMove: Move.Yield)
    }
    
   }

