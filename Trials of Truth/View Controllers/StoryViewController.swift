//
//  StoryViewController.swift
//  Trials of Truth
//
//  Created by Drew Rios on 12/7/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

protocol StoryViewControllerDelegate {
    func dismissedStoryVC()
}

struct StoryPage {
    var message: String
    var image: UIImage?
}

class StoryViewController: UIViewController {
    
    var delegate: StoryViewControllerDelegate?

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var storyImage: UIImageView!
    
    var story: [StoryPage]?
    var pageCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storyPages = story?.count {
            
            if storyPages > 1 {
                pageControl.numberOfPages = storyPages

            } else {
                pageControl.isHidden = true
                skipButton.isHidden = true
                storyLabel.textAlignment = NSTextAlignment.center

            }
        }
        
        storyLabel.text = story?[pageCounter].message
        
         storyImage.image = story?[pageCounter].image
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedStoryView(_ sender: Any) {
        

        pageCounter += 1

        
        if pageCounter == story?.count {
            self.dismiss(animated: true) {
            
                self.delegate?.dismissedStoryVC()
            }
        } else {
            pageControl.currentPage = pageCounter
            UIView.transition(with: storyLabel, duration: 0.55, options: .transitionCrossDissolve, animations: {
                 self.storyLabel.text = self.story?[self.pageCounter].message
                 self.storyImage.image = self.story?[self.pageCounter].image
            }, completion: nil)
           

        }
        
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {
            
            self.delegate?.dismissedStoryVC()
        }
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
