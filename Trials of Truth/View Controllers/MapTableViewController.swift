//
//  MapTableViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 12/28/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    @IBOutlet weak var gameScore: UILabel!
    
    var introPresented = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if introPresented  == false {
            showIntroStory()
            introPresented = true
        }
        
        updateGame()
        
    }
    
    //method to update current game state whenever the map view
    func updateGame() {
        
        gameScore.text = "\(currentUser.currentGame.gameTotalPoints)"
        
        if currentUser.currentGame.matches[0].matchIsOver == true {
            currentUser.currentGame.matchIndex = 1

        }
        
        if currentUser.currentGame.matches[1].matchIsOver == true {
            currentUser.currentGame.matchIndex = 2

        }
        
        if currentUser.currentGame.matches[2].matchIsOver == true {
            currentUser.currentGame.matchIndex = 3

        }
        
        if currentUser.currentGame.matches[3].matchIsOver == true {
            currentUser.currentGame.matchIndex = 4

        }
        
        if currentUser.currentGame.matches[4].matchIsOver == true {
            currentUser.currentGame.matchIndex = 5
        }
        
        User.saveUser()
        self.tableView.reloadData()
    }
    
    func showGameVC() {
        performSegue(withIdentifier: "ShowGameVC", sender: self)
    }
    
    func showIntroStory() {
        performSegue(withIdentifier: "ShowIntroStory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as? GameViewController
        
        nextController?.currentMatch = currentUser.currentGame.currentMatch
    }
    
    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MapTableViewCell
        
        let row =  4 - indexPath.row
        // Configure the cell...
        cell.wraithName.text = currentUser.currentGame.matches[row].currentWraith.wraithName
        cell.wraithImage.image = currentUser.currentGame.matches[row].currentWraith.wraithImage
        
        if currentUser.currentGame.matchIndex == row {
            cell.wraithName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            cell.wraithName.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        return cell
    
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row =  4 - indexPath.row
        
        if currentUser.currentGame.matchIndex == row {
            showGameVC()
        }
        
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerHeight = tableView.tableHeaderView?.frame.height ?? 0
        let navHeight =  self.navigationController?.navigationBar.frame.maxY ?? 0
        
        let totalHeight = tableView.frame.height
        
        let rowHeight = (totalHeight - (headerHeight + navHeight)) / 5
        
        return rowHeight
    }
    
}
