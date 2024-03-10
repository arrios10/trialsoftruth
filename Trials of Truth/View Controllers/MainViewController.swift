//
//  MainViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit
import GameKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var continueQuestButton: UIButton!
    @IBOutlet weak var swordImage: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var topScoresButton: UIButton!
    
    var introHasAnimated = false
    
    /* Variables */
    var gcEnabled = Bool() // Check if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Check the default leaderboardID
    
    // IMPORTANT: replace the red string below with your own Leaderboard ID (the one you've set in iTunes Connect)
    let LEADERBOARD_ID = "com.trialsoftruth.score"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        swordImage.transform = swordImage.transform.translatedBy(x: 0, y: -swordImage.frame.height)
        
        scoreLabel.isHidden = true
        logoLabel.alpha = 0
        logoLabel.transform = logoLabel.transform.scaledBy(x: 0.5, y: 0.5)
        //new stuff
        logoLabel.transform = logoLabel.transform.translatedBy(x: 0, y: swordImage.frame.height/2)

        User.loadUser()
        
        if currentUser.highScore > 0 {
            scoreLabel.isHidden = false
            scoreLabel.text = "High Score:\(currentUser.highScore)"
        }
        
        let isGameOver = currentUser.currentGame?.matches[4].matchIsOver == true
        
        
        if currentUser.currentGame == nil || isGameOver == true {
            continueQuestButton.isHidden = true
            
        } else {
            continueQuestButton.isHidden = false
        }
        
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if introHasAnimated == false {
        animateSword()
        introHasAnimated = true
        } else {
            logoLabel.alpha = 1
            swordImage.transform = .identity
            logoLabel.transform  = .identity

        }

    }
    
    func animateSword() {
        let swordAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [weak self] in
            self?.swordImage.transform = .identity
        }
        
        swordAnimator.addCompletion { [weak self] (_) in
            self?.animateLogo()
        }
        
        swordAnimator.startAnimation(afterDelay: 0.8)

    }
    
    func animateLogo() {
        let logoAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { [weak self] in
            self?.logoLabel.alpha = 1
            self?.logoLabel.transform  = .identity

        }
        
        logoAnimator.startAnimation()
    }
   
    
  
    
   
    @IBAction func startQuestButtonPressed(_ sender: Any) {
        currentUser.currentGame = Game()
    }
    
    @IBAction func topScoresButtonPressed(_ sender: Any) {
        
        // Submit score to GC leaderboard
        let bestScoreInt = GKScore(leaderboardIdentifier: LEADERBOARD_ID)
        bestScoreInt.value = Int64(currentUser.highScore)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
      
        
    }
    }
    
    
    // MARK: GC - AUTHENTICATE LOCAL PLAYER
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2. Player is already authenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
                    if let error = error { print(error)}
                    else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
                })
                
            } else {
                // 3. Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated!")
                if let error = error { print(error)}
            }
        }
    }
    
  
    
}
