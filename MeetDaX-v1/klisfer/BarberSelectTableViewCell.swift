//
//  BarberSelectTableViewCell.swift
//  klisfer
//
//  Created by aayush chaubey on 13/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class BarberSelectTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var barberimg: UIImageView!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var specialization: UILabel!
    @IBOutlet weak var barbername: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
