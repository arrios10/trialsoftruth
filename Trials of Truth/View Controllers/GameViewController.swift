//
//  GameViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var wraithMessage: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var foeActionLabel: UILabel!
    @IBOutlet weak var roundPointsLabel: UILabel!
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var yieldButton: UIButton!
    @IBOutlet weak var wraithImage: UIImageView!
    @IBOutlet weak var pointsLabelConstraint: NSLayoutConstraint!
    
    
    var storyPresented = false
    
    var currentMatch: Match!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        wraithImage.alpha = 0
        roundPointsLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if storyPresented == false && currentMatch.roundIndex == 0 {
            showStoryVC()
            storyPresented = true
        }
        
        
    }
    
    func playRound(userMove: Move) {
        let previousRound = currentMatch.currentRound!
        
        currentMatch.nextRound(userMove: userMove)
        
        // update points awarded for previous round which is scored when nextRound() is called
        roundPointsLabel.text = "+\(previousRound.roundPoints)"
        
        animatePoints()
        
        foeActionLabel.text = previousRound.computerMove == .Attack ? "The wraith has attacked" : "The wraith has yielded"
        
        updateDisplay()
    }
    
    @IBAction func attackButtonSelected(_ sender: Any) {
        playRound(userMove: Move.Attack)
    }
    
    @IBAction func yieldButtonSelected(_ sender: Any) {
        playRound(userMove: Move.Yield)
    }
    
    func checkScore() {
        //check the score against the needed pointed to advance to the next match
        switch currentUser.currentGame.matchIndex {
            
        case 0:
            if currentUser.currentGame.gameTotalPoints < 10 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 1:
            if currentUser.currentGame.gameTotalPoints < 20 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 2:
            if currentUser.currentGame.gameTotalPoints < 30 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 3:
            if currentUser.currentGame.gameTotalPoints < 40 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 4:
            if currentUser.currentGame.gameTotalPoints < 50 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            } else {
                currentUser.currentGame.gameState = GameState.Win
                User.saveUser()
                showStoryVC()
            }
        default:
            currentUser.currentGame.gameState = GameState.Started
        }
        
        
    }
    
    func exitGame() {
        
        //restart game
        currentUser.currentGame = nil
        
        //send user back to mainVC
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func showStoryVC() {
        performSegue(withIdentifier: "ShowStory", sender: self)
    }
    
    func updateDisplay() {
        let attackRate = currentMatch.calcAttackRate()
        let compAction = currentMatch.currentWraith.compMove(attackRate: attackRate, roundIndex: currentMatch.roundIndex)
        
        wraithMessage.text = compAction.message
        
        
        scoreLabel.text = "Total Score: \(currentMatch.matchTotalPoints)"
        
        if currentMatch.matchIsOver == true {
            wraithMessage.text = "Match Over"
            attackButton.isEnabled = false
            yieldButton.isEnabled  = false
            checkScore()
            
        }
    }
    
    func animatePoints() {
        pointsLabelConstraint.constant = 0
        let pointsAnimatorIn = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            self?.roundPointsLabel.alpha = 1
            self?.view.layoutIfNeeded()
        }
        
        pointsAnimatorIn.addCompletion { [weak self] (_) in
            self?.pointsLabelConstraint.constant = -8
            
            let pointsAnimatorOut = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
                self?.roundPointsLabel.alpha = 0
                self?.view.layoutIfNeeded()
            })
            pointsAnimatorOut.addCompletion({ (_) in
                self?.pointsLabelConstraint.constant = 0
            })
            pointsAnimatorOut.startAnimation(afterDelay: 1)
        }
        
        pointsAnimatorIn.startAnimation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? StoryViewController
        
        nextController?.delegate = self
        
        if currentUser.currentGame.gameState == GameState.Lose {
            nextController?.story = currentUser.currentGame.gameOverMessage
        } else if currentUser.currentGame.gameState == GameState.Win {
            nextController?.story = currentUser.currentGame.gameWinnerMessage
            
        } else {
            nextController?.story = currentUser.currentGame.currentMatch?.storyList[currentUser.currentGame.matchIndex]
        }
    }
    
    
}


extension GameViewController: StoryViewControllerDelegate {
    
    func dismissedStoryVC() {
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            self?.wraithImage.alpha = 1
        }
        
        animator.startAnimation()
        
        if currentUser.currentGame.gameState == GameState.Lose || currentUser.currentGame.gameState == GameState.Win {
            exitGame()
        }
    }
        
}

