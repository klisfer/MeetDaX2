//
//  ChooseServiceTableViewCell.swift
//  klisfer
//
//  Created by aayush chaubey on 21/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import BEMCheckBox
class ChooseServiceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
  
    @IBOutlet var service: UILabel!
    
    @IBOutlet var price: UILabel!
    
    @IBOutlet var checkbox: BEMCheckBox!
    
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
