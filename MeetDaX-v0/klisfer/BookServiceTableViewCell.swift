//
//  BookServiceTableViewCell.swift
//  klisfer
//
//  Created by aayush chaubey on 13/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class BookServiceTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var barberl: UILabel!
    
    @IBOutlet weak var barberimg: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
