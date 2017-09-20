//
//  GameViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 9/20/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    let foeMoves = ["attack", "attack","yield"]
    var foeMoveIndex = 0
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var foeActionLabel: UILabel!
    
    @IBOutlet weak var pointsAwardedLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func attackButtonSelected(_ sender: Any) {
        
        foeActionLabel.text = foeMoves[0]
        foeMoveIndex = foeMoveIndex + 1
    
    }
    
    @IBAction func yieldButtonSelected(_ sender: Any) {
        print("run")
        
    }
    
   }

