//
//  EventsTableViewCell.swift
//  klisfer
//
//  Created by aayush chaubey on 15/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var barberPic: UIImageView!
    @IBOutlet weak var serv1: UILabel?
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var serv2: UILabel?
   
   
    @IBOutlet weak var card: CardView!
    @IBOutlet weak var barberName: UILabel!
    
    @IBOutlet weak var dat: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
