//
//  promotionsViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 26/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class promotionsViewController: UIViewController {

    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.frame = CGRect(x:0 , y: 0 , width: view.frame.width , height: 3*(view.frame.height/4))
        //viewProm.backgroundColor = UIColor(patternImage: UIImage(named: "promotion1a.png")!)
        viewProm.frame = CGRect(x:0 , y: 0 , width: view.frame.width , height: 3*(view.frame.height/4))
        
        
        
        priceBtn.backgroundColor = UIColor(hexString: "#F24E86ff")
        priceBtn.layer.shadowColor = UIColor.black.cgColor
        priceBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        priceBtn.layer.shadowRadius = 6
        priceBtn.layer.shadowOpacity = 0.4
        priceBtn.layer.cornerRadius = 6
        
        
        
        bookNowBtn.backgroundColor = UIColor(hexString: "#F24E86ff")
        bookNowBtn.layer.shadowColor = UIColor.black.cgColor
        bookNowBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        bookNowBtn.layer.shadowRadius = 6
        bookNowBtn.layer.shadowOpacity = 0.4
        bookNowBtn.layer.cornerRadius = 6
        
        
        
        iconBtn.backgroundColor = UIColor(hexString: "#ffffffff")
        iconBtn.layer.shadowColor = UIColor.black.cgColor
        iconBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        iconBtn.layer.shadowRadius = 6
        iconBtn.layer.shadowOpacity = 0.4
        iconBtn.layer.cornerRadius = 6
        
        
        
        serv1.text = self.delegate.prom_serv1[0]
        serv2.text = self.delegate.prom_serv2[0]
        serv3.text = self.delegate.prom_serv3[0]
        packageName.text = self.delegate.prom_name[0]
        priceBtn.setTitle((" \(self.delegate.prom_price[0]) dk"),for: .normal)
 
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var viewProm: UIView!
    @IBOutlet weak var priceBtn: UIButton!
    

    @IBOutlet weak var serv1: UILabel!
    @IBOutlet weak var serv2: UILabel!
    
    @IBOutlet weak var serv3: UILabel!
    
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var iconBtn: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
