//
//  MapViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 10/13/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var knightOneButton: UIButton!
    
    @IBOutlet weak var knightTwoButton: UIButton!
    
    @IBOutlet weak var knightThreeButton: UIButton!
    
    var currentGame: Game! = Game()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    //method to update current game state whenever the map view appears
    
    //enable/disable knight buttons
    
    //track progress through game in order from first knight to last knight
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? GameViewController
        
        let currentMatch = Match()
        nextController?.currentMatch = currentMatch
        currentGame.matches.append(currentMatch)
    }
}
