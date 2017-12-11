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
    var storyPresented = false
    
    var currentMatch: Match!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateDisplay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if storyPresented == false && currentMatch.roundIndex == 0 {
            performSegue(withIdentifier: "ShowStory", sender: self)
            storyPresented = true
        }

    }
    
    func playRound(userMove: Move) {
        let previousRound = currentMatch.currentRound!
        
        currentMatch.nextRound(userMove: userMove)
        
        // update points awarded for previous round which is scored when nextRound() is called
        pointsAwardedLabel.text = String(previousRound.roundPoints)
        
        updateDisplay()
    }
    
    @IBAction func attackButtonSelected(_ sender: Any) {
        playRound(userMove: Move.Attack)
    }
    
    @IBAction func yieldButtonSelected(_ sender: Any) {
        playRound(userMove: Move.Yield)
    }
    
    func endGame() {
        //check the score against the needed pointed to advance to the next match
        
        //show story
        
        //disable button
        
    }
    
    func exitGame() {
        //restart game
        
        
        //send user back to mainVC
        navigationController?.popToRootViewController(animated: true)
    }
    
    func updateDisplay() {
        let attackRate = currentMatch.calcAttackRate()
        let compAction = currentMatch.currentWraith.compMove(attackRate: attackRate, roundIndex: currentMatch.roundIndex)
        
        messageLabel.text = compAction.message
        
        let currentRound = currentMatch.currentRound!
        foeActionLabel.text = currentRound.computerMove == .Attack ? "Your foe has attacked" : "Your foe has yielded"
        scoreLabel.text = String(currentMatch.matchTotalPoints)
        
        if currentMatch.roundIndex == ROUND_COUNT - 1 {
            messageLabel.text = "Match Over"
            attackButton.isEnabled = false
            yieldButton.isEnabled  = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? StoryViewController
        
        nextController?.story = currentGame.currentMatch?.storyList[currentGame.matchIndex]
    }
    
}

