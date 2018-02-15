//
//  MainViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var continueQuestButton: UIButton!
    @IBOutlet weak var swordImage: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    
    var introHasAnimated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        swordImage.transform = swordImage.transform.translatedBy(x: 0, y: -swordImage.frame.height)
        
        logoLabel.alpha = 0
        logoLabel.transform = logoLabel.transform.scaledBy(x: 0.5, y: 0.5)
        //new stuff
        logoLabel.transform = logoLabel.transform.translatedBy(x: 0, y: swordImage.frame.height/2)

        User.loadUser()
        
        let isGameOver = currentUser.currentGame?.matches[4].matchIsOver == true
        
        if currentUser.currentGame == nil || isGameOver == true {
            continueQuestButton.isEnabled = false
        } else {
            continueQuestButton.isEnabled = true
        }
        
        scoreLabel.text = "Your High Score Is: \(currentUser.highScore)"
        
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
    
   
    @IBAction func startQuestButton(_ sender: Any) {
        currentUser.currentGame = Game()
    }
    
}
