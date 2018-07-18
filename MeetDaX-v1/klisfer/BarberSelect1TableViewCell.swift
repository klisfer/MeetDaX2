//
//  BarberSelect1TableViewCell.swift
//  klisfer
//
//  Created by aayush chaubey on 24/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class BarberSelect1TableViewCell: UITableViewCell {

    
    @IBOutlet weak var barberimg: UIImageView!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var specialization: UILabel!
    @IBOutlet weak var barbername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
