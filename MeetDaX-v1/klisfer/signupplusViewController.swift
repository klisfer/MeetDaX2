//
//  signupplusViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 05/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FBSDKCoreKit
import FirebaseFirestore
import DynamicColor
import AnimatableReload
class signupplusViewController: UIViewController , UITableViewDataSource  , UITableViewDelegate {
    
    let stuff = ["milk" , "cheese" , "bread"]
    var services = [services_common]()

    @IBOutlet var option: [UIButton]!
    
    @IBOutlet weak var serviceTable: UITableView!
    var tableViewHeight:CGFloat?
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
  
    var cover1 = UIView()
    var cover2 = UIView()
    var mask1 = UIView()
    var mask2 = UIView()
  
    @IBOutlet weak var callBtn: UIButton!
  
    @IBOutlet var navigateBtn: UIButton!
    
    
    @IBOutlet weak var appt_btn: UIButton!
    @IBOutlet weak var navbar: UINavigationItem!
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return (services.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! signupPlusTableCellTableViewCell
        
        cell.servName.text = services[indexPath.row].name
        cell.servPrice.text = String(services[indexPath.row].price)
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        //button to make appointmeent
        print("current user for image upload: \((Auth.auth().currentUser?.uid)!)")
        tableviewHeight.constant = 0
         appt_btn.layer.cornerRadius = 6
        
        // or for Swift 3
        
    
        fetchingData2(completion : {  success in
            self.services = objects.sharedManager.servicessMen

        })
        
        
        
        
        let nav = self.navigationController?.navigationBar
        
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (nav?.frame.size.width)!, height: (nav?.frame.size.height)!))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Logo_Salon5avenue-white")
        imageView.image = image
        
        // 5
        navigationItem.titleView = imageView
        
        
        
    
        
      
    }
    override func viewDidLayoutSubviews() {
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
        appt_btn.applyGradient(colours: [UIColor(hexString: "#2F2F2F"), UIColor(hexString: "#292929"), UIColor(hexString: "#40079B")], locations: [0.0, 0.5, 1])
        appt_btn.layer.masksToBounds = true
        
        
        navigateBtn.applyGradients(colours: [UIColor(hexString: "#535353"), UIColor(hexString: "#383838")], locations: [0.5, 1.0])
        navigateBtn.layer.masksToBounds = true
        
        
        callBtn.applyGradients(colours: [UIColor(hexString: "#535353"), UIColor(hexString: "#383838")], locations: [0.5, 1.0])
        callBtn.layer.masksToBounds = true
        
//        CATransaction.commit()
    }
    
    var phoneNo : String = "+917358097519"
    
    @IBAction func callBtnAct(_ sender: Any) {
        if let url = URL(string: "tel://\(phoneNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }

    
    }
    
    
    @IBAction func optionAction(_ sender: UIButton) {
    
        switch (sender.tag) {
        case 1:
            
            tableViewHeight = CGFloat(70*(services.count));
            tableviewHeight.constant = tableViewHeight!
            
            
            print("bhak 1")
            for  (i,option) in option.enumerated() {
                if(i != 0){
                    option.isSelected = false
                    option.backgroundColor = UIColor(hexString: "#ffffffff")
                    option.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            services = objects.sharedManager.servicessMen
            //self.serviceTable.reloadData()
            AnimatableReload.reload(tableView: self.serviceTable, animationDirection: "up")

            sender.backgroundColor = UIColor(hexString: "#4D58E2ff")
            sender.setTitleColor(UIColor.white, for: .normal)
            tableViewHeight = CGFloat(70*(services.count));
            tableviewHeight.constant = tableViewHeight!
            
        case 2:
            tableViewHeight = CGFloat(70*(services.count));
            tableviewHeight.constant = tableViewHeight!
            print("bhak 2")
            for  (i,option) in option.enumerated() {
                if(i != 1){
                    option.isSelected = false
                    option.backgroundColor = UIColor(hexString: "#ffffffff")
                    option.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            services = objects.sharedManager.servicessWomen
            
            AnimatableReload.reload(tableView: self.serviceTable, animationDirection: "up")
            
            sender.backgroundColor = UIColor(hexString: "#4D58E2ff")
            sender.setTitleColor(UIColor.white, for: .normal)
            tableViewHeight = CGFloat(70*(services.count));
            tableviewHeight.constant = tableViewHeight!
            
        case 3:
            tableViewHeight = CGFloat(70*(services.count));
            tableviewHeight.constant = tableViewHeight!
            print("bhak 3")
            for  (i,option) in option.enumerated() {
                if(i != 2){
                    option.isSelected = false
                    option.backgroundColor = UIColor(hexString: "#ffffffff")
                    option.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            services = objects.sharedManager.servicessChildren
            //self.serviceTable.reloadData()
            AnimatableReload.reload(tableView: self.serviceTable, animationDirection: "up")
            sender.backgroundColor = UIColor(hexString: "#4D58E2ff")
            sender.setTitleColor(UIColor.white, for: .normal)
            tableViewHeight = CGFloat(70*(services.count));
            tableviewHeight.constant = tableViewHeight!
            
        default:
            services = objects.sharedManager.servicessMen
            self.serviceTable.reloadData()
            
        }
    
    
    
    }
    
    
    
    
    
    
    
    
    
    @IBAction func navBtnAct(_ sender: Any) {
        
        let lat = 54.914340
        let long = 9.796964
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:
                "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")!)
            
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    
        
    
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        // OLD QUERIES
        //let delegate = UIApplication.shared.delegate as! AppDelegate
        //let db = Firestore.firestore()
        dataToPost.sharedManager.switchToEventFlag = false
        
        
        
        
    }
    
    

    
    private func setupLayout(){
        
        //card1.backgroundColor = UIColor(patternImage: UIImage(named: "Promotion2.png")!)
        //card2.backgroundColor = UIColor(patternImage: UIImage(named: "Promotion1.png")!)
      //  appt_btn.addTarget(self, action: #selector(bookApt), for: .touchUpInside)
        
        let blue   = UIColor(hexString: "#000000")
        let red    = UIColor(hexString: "#2F2F2F")
        let yellow = UIColor(hexString: "#292929")
        let purple = UIColor(hexString: "#40079B")
        let gradient = DynamicGradient(colors: [blue, red, yellow])
//        appt_btn.applyGradient(colours: [UIColor(hexString: "#2F2F2F"), UIColor(hexString: "#292929"), UIColor(hexString: "#40079B")], locations: [0.0, 0.4, 0.7])
//        appt_btn.layer.masksToBounds = true
        
        
        
        
        
//        card1.addSubview(cover1)
//        cover1.frame = CGRect(x: 0 ,y: 160 ,width: card1.frame.width  , height: 12)
//        cover1.backgroundColor = .white
//        card2.addSubview(cover2)
//        cover2.frame = CGRect(x: 0 ,y: 160 ,width: card2.frame.width  , height: 12)
//        cover2.backgroundColor = .white
//
//
//        card1.addSubview(mask1)
//        mask1.frame = CGRect(x:0, y:0, width:view.frame.width - 40, height:220)
//        mask1.backgroundColor = UIColor(hexString: "#00000000")
//        card2.addSubview(mask2)
//        mask2.frame = CGRect(x:0, y: 0, width:view.frame.width - 40, height:220)
//        mask2.backgroundColor = UIColor(hexString: "#00000000")
        
        
        //button on mask1
        let mon1 = UIButton()
        let mon11 = UIButton()
        mask1.addSubview(mon1)
        mask1.addSubview(mon11)
        mon1.frame = CGRect(x: 20 ,y: 125 ,width: 40,height: 40)
        mon11.frame = CGRect(x: 75 ,y: 125 ,width: 100,height: 40)
        mon1.backgroundColor = .white
        mon11.backgroundColor = UIColor(hexString: "#1C92AFff")
        mon1.layer.shadowColor = UIColor.black.cgColor
        mon11.layer.shadowColor = UIColor.black.cgColor
        mon1.layer.shadowOffset = CGSize(width: 3, height: 3)
        mon11.layer.shadowOffset = CGSize(width: 3, height: 3)
        mon1.layer.shadowRadius = 3
        mon11.layer.shadowRadius = 3
        mon1.layer.shadowOpacity = 0.7
        mon11.setTitle("500 dkk", for: UIControlState.normal)
        mon11.layer.shadowOpacity = 1.0
        mon1.layer.cornerRadius = 6
        mon11.layer.cornerRadius = 6
        
        //button on mask 2
        let mon2 = UIButton()
        let mon22 = UIButton()
        mask2.addSubview(mon2)
        mask2.addSubview(mon22)
        mon2.frame = CGRect(x: 20 ,y: 125 ,width: 40,height: 40)
        mon22.frame = CGRect(x: 75 ,y: 125 ,width: 100,height: 40)
        mon2.backgroundColor = .white
        mon22.backgroundColor = UIColor(hexString: "#1C92AFff")
        mon2.layer.shadowColor = UIColor.black.cgColor
        mon22.layer.shadowColor = UIColor.black.cgColor
        mon2.layer.shadowOffset = CGSize(width: 3, height: 3)
        mon22.layer.shadowOffset = CGSize(width: 3, height: 3)
        mon2.layer.shadowRadius = 3
        mon22.layer.shadowRadius = 3
        mon2.layer.shadowOpacity = 0.7
        mon22.setTitle("500 dkk", for: UIControlState.normal)
        mon22.layer.shadowOpacity = 1.0
        mon2.layer.cornerRadius = 6
        mon22.layer.cornerRadius = 6
        
        
//        promotinpic1.layer.cornerRadius = 12;
//        promotinpic1.clipsToBounds = true;
//        promotinpic2.layer.cornerRadius = 12;
//        promotinpic2.clipsToBounds = true;
//        offerserv1.layer.cornerRadius = 12;
//        offerserv1.clipsToBounds = true;
//        offerserv2.layer.cornerRadius = 12;
//        offerserv2.clipsToBounds = true;
        
        
        
        //call button
        callBtn.layer.shadowColor = UIColor.black.cgColor
        callBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        callBtn.layer.shadowRadius = 2
        callBtn.layer.shadowOpacity = 0.5
        callBtn.layer.cornerRadius = 6
        callBtn.backgroundColor = .darkGray
       
      
        navigateBtn.layer.shadowColor = UIColor.black.cgColor
        navigateBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        navigateBtn.layer.shadowRadius = 2
        navigateBtn.layer.shadowOpacity = 0.5
        navigateBtn.layer.cornerRadius = 6
        navigateBtn.backgroundColor = .darkGray
        
        
    }
    
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0 , y: 0)
        gradient.endPoint = CGPoint(x: 1 , y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradients(colours: [UIColor]) -> Void {
        self.applyGradients(colours: colours, locations: nil)
    }
    
    func applyGradients(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0 , y: 0)
        gradient.endPoint = CGPoint(x: 0 , y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
