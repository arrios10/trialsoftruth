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
        
        if let data = UserDefaults.standard.data(forKey: "currentGame"),
            let game = NSKeyedUnarchiver.unarchiveObject(with: data) as? Game {
            currentGame = game
            print("gameTotalPoints: \(currentGame.gameTotalPoints)")
        } else {
            print("No game data")
        }
        
        let isGameOver = currentGame?.matches.count == 5 && currentGame?.matches[4].matchIsOver == true
        
        if currentGame == nil || isGameOver == true {
            continueQuestButton.isEnabled = false
        } else {
            continueQuestButton.isEnabled = true
        }
        
    }
   
    @IBAction func startQuestButton(_ sender: Any) {
        currentGame = Game()
    }
    
    

}
