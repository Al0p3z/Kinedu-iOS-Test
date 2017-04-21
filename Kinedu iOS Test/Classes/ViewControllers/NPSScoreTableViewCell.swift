//
//  NPSScoreTableViewCell.swift
//  Kinedu iOS Test
//
//  Created by Luis Angel Lopez Bernal on 20/04/17.
//  Copyright © 2017 UANL. All rights reserved.
//
import UIKit

class NPSScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
