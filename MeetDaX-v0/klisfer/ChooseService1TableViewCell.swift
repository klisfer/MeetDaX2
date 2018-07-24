//
//  ChooseService1TableViewCell.swift
//  klisfer
//
//  Created by aayush chaubey on 24/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import BEMCheckBox
class ChooseService1TableViewCell: UITableViewCell {

    @IBOutlet var service: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var checkbox: BEMCheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
