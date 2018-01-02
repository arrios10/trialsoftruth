//
//  MapTableViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 12/28/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class MapTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        wraithTwoButton.isEnabled = false
//        wraithThreeButton.isEnabled = false
//        wraithFourButton.isEnabled = false
//        wraithFiveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGame()
    }
    
    //method to update current game state whenever the map view
    func updateGame() {
        
        //totalGameScore.text = "\(currentUser.currentGame.gameTotalPoints)"
        
        if currentUser.currentGame.matches[0].matchIsOver == true {
            currentUser.currentGame.matchIndex = 1
//            wraithTwoButton.isEnabled = true
//            wraithOneButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[1].matchIsOver == true {
            currentUser.currentGame.matchIndex = 2
//            wraithThreeButton.isEnabled = true
//            wraithTwoButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[2].matchIsOver == true {
            currentUser.currentGame.matchIndex = 3
//            wraithFourButton.isEnabled = true
//            wraithThreeButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[3].matchIsOver == true {
            currentUser.currentGame.matchIndex = 4
//            wraithFiveButton.isEnabled = true
//            wraithFourButton.isEnabled = false
        }
        
        if currentUser.currentGame.matches[4].matchIsOver == true {
            currentUser.currentGame.matchIndex = 5
//            wraithFiveButton.isEnabled = false
        }
        
        User.saveUser()
    }
    
    func showGameVC() {
        performSegue(withIdentifier: "ShowGameVC", sender: self)
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
