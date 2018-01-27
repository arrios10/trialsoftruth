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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        swordImage.transform = swordImage.transform.translatedBy(x: 0, y: -swordImage.frame.height)
        
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
        animateSword()
    }
    
    func animateSword() {
        let swordAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak self] in
            self?.swordImage.transform = .identity
        }
        swordAnimator.startAnimation(afterDelay: 1)
    }
   
    @IBAction func startQuestButton(_ sender: Any) {
        currentUser.currentGame = Game()
    }
    
}
