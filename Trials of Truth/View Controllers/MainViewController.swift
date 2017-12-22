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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        User.loadUser()
        

        
        let isGameOver = currentUser.currentGame?.matches[4].matchIsOver == true
        
        if currentUser.currentGame == nil || isGameOver == true {
            continueQuestButton.isEnabled = false
        } else {
            continueQuestButton.isEnabled = true
        }
        
        scoreLabel.text = "Your High Score Is: \(currentUser.highScore)"

        
    }
   
    @IBAction func startQuestButton(_ sender: Any) {
        currentUser.currentGame = Game()
    }
    
}