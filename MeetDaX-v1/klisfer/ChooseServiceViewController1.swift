//
//  ChooseServiceViewController1.swift
//  klisfer
//
//  Created by aayush chaubey on 24/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import PMSuperButton
import JASON
import BEMCheckBox

class ChooseServiceViewController1: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var list = ["sbc" , "def" ,"jkl" , "mno"]
    var checked : [Int] = []
    let db = Firestore.firestore()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var serv1: UILabel!
    @IBOutlet weak var serv2: UILabel!
    @IBOutlet weak var barberImage: UIImageView!
    @IBOutlet weak var barberName: UILabel!
    @IBOutlet weak var viewScroll: UIView!
    
    @IBOutlet var option: [UIButton]!
    
    @IBOutlet var checkBox: BEMCheckBox!
    
    @IBOutlet weak var card: CardView!
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var tableviewHeightConst: NSLayoutConstraint!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var nxtBtnTop: NSLayoutConstraint!
    
    var services = [services_common]()
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChooseService1TableViewCell
        cell.service.text = services[indexPath.row].name
        //let price: String? =  String(services[indexPath.row].price)
        cell.price.text = String(services[indexPath.row].price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChooseService1TableViewCell
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            let indx = checked.index(of:indexPath.row)
            if(checked.contains(indexPath.row)){
                if let index = checked.index(of:indexPath.row) {
                    checked.remove(at: index)
                }
            }
            //var indx = Int()
            
            
            if(indx == 0){
                serv1.text = " "
                serv1.text = serv2.text
                serv2.text = " "
            }else if (indx == 1){
                serv2.text = " "
            }
        }else if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none) && (checked.count<=1){
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
           
            
            if(checked.count == 0){
                serv1.text = Array(services)[indexPath.row].name
            }else if (checked.count == 1){
                serv2.text = Array(services)[indexPath.row].name
            }
            
            if(!(checked.contains(indexPath.row))){
                checked.append(indexPath.row)
            }
            
            
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSetup()
        for i in option{
            i.layer.cornerRadius = 5
        }
        let img = UIImage(named: "card-bg")
        card.backgroundColor = UIColor(patternImage: img!)
        
        self.tableview.separatorStyle = .none
        services = objects.sharedManager.servicessMen
        //empty the temp services meant for calculating duration.
        objects.sharedManager.servicesTemp.removeAll()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let tableViewHeight:CGFloat = CGFloat(70*(services.count));
        
        tableviewHeightConst.constant = tableViewHeight
        nxtBtnTop.constant = tableViewHeight + 130
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        
        switch (sender.tag) {
        case 1:
            for  (i,option) in option.enumerated() {
                if(i != 0){
                    option.isSelected = false
                    option.backgroundColor = UIColor(hexString: "#ffffffff")
                    option.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            services = objects.sharedManager.servicessMen
            self.tableview.reloadData()
            sender.backgroundColor = UIColor(hexString: "#4B4D4Dff")
            sender.setTitleColor(UIColor.white, for: .normal)
            
            
        case 2:
            for  (i,option) in option.enumerated() {
                if(i != 1){
                    option.isSelected = false
                    option.backgroundColor = UIColor(hexString: "#ffffffff")
                    option.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            services = objects.sharedManager.servicessWomen
            self.tableview.reloadData()
            sender.backgroundColor = UIColor(hexString: "#4B4D4Dff")
            sender.setTitleColor(UIColor.white, for: .normal)
            
            
        case 3:
            for  (i,option) in option.enumerated() {
                if(i != 2){
                    option.isSelected = false
                    option.backgroundColor = UIColor(hexString: "#ffffffff")
                    option.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            services = objects.sharedManager.servicessChildren
            self.tableview.reloadData()
            
            sender.backgroundColor = UIColor(hexString: "#4B4D4Dff")
            sender.setTitleColor(UIColor.white, for: .normal)
            
        default:
            services = objects.sharedManager.servicessMen
            self.tableview.reloadData()
            
        }
        
    }
    
    private func layoutSetup(){
        //TOPVIEW
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        
        //next button outside bottomview
        //let button = UIButton()
        nextBtn.setTitle("NEXT", for: .normal)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.backgroundColor = UIColor(hexString: "#4B4D4Dff")
        //button.translatesAutoresizingMaskIntoConstraints = false
        //button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        //button.frame = CGRect(x: 25, y: 560, width: Int(screenWidth-50), height: 50)
        //button.addTarget(self, action: #selector(btnAction),for: .touchUpInside)
        nextBtn.layer.shadowColor = UIColor.black.cgColor
        //button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        nextBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        nextBtn.layer.shadowRadius = 2
        nextBtn.layer.shadowOpacity = 0.5
        nextBtn.layer.cornerRadius = 6
        nextBtn.applyGradients(colours: [UIColor(hexString: "#535353"), UIColor(hexString: "#383838")], locations: [0.5, 1.0])
        nextBtn.layer.masksToBounds = true
        
        //self.viewScroll.addSubview(button)
        
    }
    
    @IBAction func nextBtnAct(_ sender: Any) {
    
        if (checked.count > 2 ) {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "You can select maximum of 2 services at a time", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else if (checked.count == 0){
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Select atleast 1 service", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }else{
            objects.sharedManager.stylistDataF2.removeAll()
            var arr = [String]()
            var arr1 = [String]()
            var price : Int = 0
            var stylist1Id = [String]()
            var stylist2Id = [String]()
            var stylistId = [String]()
            arr.removeAll()
            arr1.removeAll()
            stylistId.removeAll()
            for (k,i) in checked.enumerated(){
                objects.sharedManager.servicesTemp.append(services[i])
                arr.append(services[i].id)
                arr1.append(services[i].name)
                price = price + services[i].price
                
                if(k == 0){
                    for j in services[i].services{
                        
                        stylist1Id.append(j[1])
                    }
                }else if (k == 1){
                    for j in services[i].services{
                        stylist2Id.append(j[1])
                    }
                }
            }
            
            // getting common stylists for both services
            if !(stylist2Id.isEmpty){
                for i in stylist1Id{
                    for j in stylist2Id{
                        if(i==j){
                            stylistId.append(i)
                        }
                    }
                }
                
            }else{
                stylistId = stylist1Id
            }
            // getting duration of all stylists
            
            
            
            
            
            
            
            for i in stylistId{
                for j in objects.sharedManager.stylistData {
                    if(j.id == i){
                        objects.sharedManager.stylistDataF2.append(j)
                    }
                }
            }
            dataToPost.sharedManager.price = price
            dataToPost.sharedManager.services = arr
            dataToPost.sharedManager.servicesNames = arr1
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "barberSelect1")
            //            self.present(vc!, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc!, animated: true)
            
            
            
        }
        
        
    }
    
    @objc private func btnAction(sender: UIButton!){
        
     
    }
    
    
    
}
