//
//  GameViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var wraithMessage: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundPointsLabel: UILabel!
    @IBOutlet weak var swordButton: UIButton!
    @IBOutlet weak var shieldButton: UIButton!
    @IBOutlet weak var wraithImage: UIImageView!
    @IBOutlet weak var roundPageControl: UIPageControl!
    
    private var pointsAnimator: UIViewPropertyAnimator?
       
    var currentMatch: Match!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        wraithImage.image = currentMatch.currentWraith.wraithImage
        
        if currentMatch.roundIndex == 0 {
            wraithImage.alpha = 0
        }
        roundPointsLabel.alpha = 0
        actionImage.alpha = 0

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if currentMatch.roundIndex == 0 {
            showStoryVC()
        }
        
        
    }
    
    func playRound(userMove: Move) {
        let previousRound = currentMatch.currentRound!
        
        currentMatch.nextRound(userMove: userMove)
        
        // update points awarded for previous round which is scored when nextRound() is called
        roundPointsLabel.text = "\(previousRound.roundPoints)"
        
        animatePointsIn()
        
        if previousRound.wraithMove == .Sword {
            animateSlash()
        } else {
            animateShield()
        }
        
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
            } else {
                animateWraithDefeat()
            }
        case 1:
            if currentUser.currentGame.gameTotalPoints < 8 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            } else {
                animateWraithDefeat()
            }
        case 2:
            if currentUser.currentGame.gameTotalPoints < 13 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            } else {
                animateWraithDefeat()
            }
        case 3:
            if currentUser.currentGame.gameTotalPoints < 21 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            }   else {
                animateWraithDefeat()
            }
        case 4:
            if currentUser.currentGame.gameTotalPoints < 34 {
                currentUser.currentGame.gameState = GameState.Lose
                showStoryVC()
            } else {
                animateWraithDefeat()
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
     
        scoreLabel.text = "\(currentUser.currentGame.gameTotalPoints)"
        roundPageControl.currentPage = currentMatch.roundIndex
        
        
        if currentMatch.matchIsOver == true {
            wraithMessage.text = "Wraith Defeated.\nAdvance to the next Level."
            swordButton.isEnabled = false
            swordButton.isHidden = true
            shieldButton.isEnabled  = false
            shieldButton.isHidden = true
            roundPageControl.isHidden = true

            checkScore()
            
        } else {
            
            let attackRate = currentMatch.calcAttackRate()
            let compAction = currentMatch.currentWraith.compMove(attackRate: attackRate, roundIndex: currentMatch.roundIndex)
            
            wraithMessage.text = compAction.message

        }
    }
    
    func animatePointsIn() {
        pointsAnimator?.stopAnimation(true)

        roundPointsLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)

        pointsAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) { [weak self] in
            self?.roundPointsLabel.alpha = 1
            self?.roundPointsLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.8, y: 1.8)
            
        }
        
        pointsAnimator?.addCompletion { [weak self] (_) in
            self?.animatePointsOut()
        }
        pointsAnimator?.startAnimation()
        
    }
    
    func animatePointsOut() {
       
        pointsAnimator = UIViewPropertyAnimator(duration: 0.35, curve: .easeInOut, animations: { [weak self] in
            self?.roundPointsLabel.alpha = 0.3
            self?.roundPointsLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)

        })
        pointsAnimator?.startAnimation(afterDelay: 0.2)
    }
    
    func animateSlash() {
        actionImage.image = #imageLiteral(resourceName: "slashImage")
        actionImage.alpha = 1
        let imagePercent = actionImage.bounds.height * 0.1
        let randomY = (imagePercent * 0.5) - CGFloat(arc4random_uniform(UInt32(imagePercent)))
        let randomX = (imagePercent * 0.5) - CGFloat(arc4random_uniform(UInt32(imagePercent)))
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: randomX, y: randomY)
        
        let randomScale = 0.5 + (CGFloat(arc4random_uniform(5))/10.0)
        transform = transform.scaledBy(x: randomScale, y: randomScale)
        transform = transform.rotated(by: randomScale)

        actionImage.transform = transform

        let slashAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) { [weak self] in
            self?.actionImage.transform = transform.scaledBy(x: 0.6, y: 0.6)
            self?.actionImage.alpha = 0

        }
        slashAnimator.startAnimation()
    }
    
    func animateShield() {
        actionImage.image = #imageLiteral(resourceName: "shieldImage")
        actionImage.alpha = 1
        
        actionImage.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)
        
        let shieldAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            self?.actionImage.transform = .identity
            self?.actionImage.alpha = 0

        }
        
        shieldAnimator.startAnimation()
    }
    
    func animateWraithDefeat() {
        
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: 0, y: 0)
        transform = transform.scaledBy(x: 0.01, y: 0.01)
        transform = transform.rotated(by:1)
        
        let defeatAnimator = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut) { [weak self] in
            self?.wraithImage.transform = CGAffineTransform.identity.rotated(by: 4)
            self?.wraithImage.alpha = 0
            self?.wraithImage.transform = transform
        }
        
        defeatAnimator.addCompletion { [weak self](_) in
            self?.animateShield()
        }
        
        defeatAnimator.startAnimation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? StoryViewController
        
        nextController?.delegate = self
        
        if currentUser.currentGame.gameState == GameState.Lose {
            nextController?.story = currentUser.currentGame.gameOverMessage
        } else if currentUser.currentGame.gameState == GameState.Win {
            nextController?.story = currentUser.currentGame.gameWinnerMessage
            
        } else {
            nextController?.story = [currentUser.currentGame.currentMatch!.storyList[currentUser.currentGame.matchIndex]]
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

