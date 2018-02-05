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
    @IBOutlet weak var swordButton: UIButton!
    @IBOutlet weak var shieldButton: UIButton!
    @IBOutlet weak var wraithImage: UIImageView!
    @IBOutlet weak var pointsLabelConstraint: NSLayoutConstraint!
    
    private var pointsAnimator: UIViewPropertyAnimator?
    
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
        
        animatePointsIn()
        
        foeActionLabel.text = previousRound.wraithMove == .Sword ? "The wraith has attacked" : "The wraith has yielded"
        
        updateDisplay()
    }
    
    @IBAction func swordButtonSelected(_ sender: Any) {
        playRound(userMove: Move.Sword)
    }
    
    @IBAction func shieldButtonSelected(_ sender: Any) {
        playRound(userMove: Move.Shield)
    }
    
    func checkScore() {
        //check the score against the needed pointed to advance to the next match
        switch currentUser.currentGame.matchIndex {
            
        case 0:
            if currentUser.currentGame.gameTotalPoints < 5 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 1:
            if currentUser.currentGame.gameTotalPoints < 8{
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 2:
            if currentUser.currentGame.gameTotalPoints < 13 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 3:
            if currentUser.currentGame.gameTotalPoints < 21 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }
        case 4:
            if currentUser.currentGame.gameTotalPoints < 34 {
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
            swordButton.isEnabled = false
            shieldButton.isEnabled  = false
            checkScore()
            
        }
    }
    
    func animatePointsIn() {
        pointsAnimator?.stopAnimation(true)

        pointsLabelConstraint.constant = 0
        pointsAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) { [weak self] in
            self?.roundPointsLabel.alpha = 1
            self?.view.layoutIfNeeded()
        }
        
        pointsAnimator?.addCompletion { [weak self] (_) in
            self?.animatePointsOut()
        }
        pointsAnimator?.startAnimation()
        
    }
    
    func animatePointsOut() {

        pointsLabelConstraint.constant = -8
        
        pointsAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: { [weak self] in
            self?.roundPointsLabel.alpha = 0
            self?.view.layoutIfNeeded()
        })
        pointsAnimator?.addCompletion({ [weak self] (_) in
            self?.pointsLabelConstraint.constant = 0
        })
        pointsAnimator?.startAnimation(afterDelay: 0.5)
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

