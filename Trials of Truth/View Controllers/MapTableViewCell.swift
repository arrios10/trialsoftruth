//
//  MapTableViewCell.swift
//  Trials of Truth
//
//  Created by Drew Rios on 12/28/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var wraithImage: UIImageView!
    
    @IBOutlet weak var wraithName: UILabel!
    
    @IBOutlet weak var totalGameScore: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
