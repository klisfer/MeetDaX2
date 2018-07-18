//
//  ChooseServiceViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 07/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import PMSuperButton
import JASON
import BEMCheckBox

class ChooseServiceViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    let  list  =  ["abc" , "qwe" , "yui" , "qwerty"]
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
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var nextBtnTop: NSLayoutConstraint!
    
    @IBOutlet var tableHeightConst: NSLayoutConstraint!
    var servMen = [services_common]()
    var servWomen = [services_common]()
    var servChildren = [services_common]()
    var services = [services_common]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .red
        layoutSetup()
        setupNavigationBar()
        
        for i in option{
            i.layer.cornerRadius = 5
        }
        
        
        let img = UIImage(named: "card-bg")
        card.backgroundColor = UIColor(patternImage: img!)
       
   
      
        
        for (i , doc) in objects.sharedManager.servicessMen.enumerated(){
            for (j , docc) in doc.services.enumerated() {
                if(docc[1] == dataToPost.sharedManager.stylistId ){
                  servMen.append(doc)
                  
                }
             }
         }
        for (i , doc) in objects.sharedManager.servicessWomen.enumerated(){
            for (j , docc) in doc.services.enumerated() {
                if(docc[1] == dataToPost.sharedManager.stylistId ){
                    servWomen.append(doc)
                    
                }
            }
        }
        for (i , doc) in objects.sharedManager.servicessChildren.enumerated(){
            for (j , docc) in doc.services.enumerated() {
                if(docc[1] == dataToPost.sharedManager.stylistId ){
                    servChildren.append(doc)
                    
                }
            }
        }
        services = servMen
      
        // setting barber name and image
        self.barberName.text = dataToPost.sharedManager.stylistName
        let url = URL(string: dataToPost.sharedManager.imgUrl)
        self.barberImage.kf.setImage(with: url)
        print("service docs \(services)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let tableViewHeight:CGFloat = CGFloat(70*(services.count));
        
        tableHeightConst.constant = tableViewHeight
        nextBtnTop.constant = tableViewHeight + 130
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return (services.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChooseServiceTableViewCell
        
        cell.service.text = services[indexPath.row].name
        let price: String? =  String(services[indexPath.row].price)
        cell.price.text = price
        // cross checking for checked rows
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChooseServiceTableViewCell
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
    
    @IBAction func checkboxSelected(_ sender: BEMCheckBox) {
       
       
      
    }
    
    
    
    var user : String?
    var stylist : String?
    
    @IBOutlet weak var navBar: UINavigationItem!
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var tableview: UITableView!
    
   
   
   
    
   
    private func setupNavigationBar(){
        
        
        navigationItem.title = "Home"
        
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
            services = servMen
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
            services = servWomen
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
            services = servChildren
            self.tableview.reloadData()
         
            sender.backgroundColor = UIColor(hexString: "#4B4D4Dff")
            sender.setTitleColor(UIColor.white, for: .normal)
         
        default:
            services = servMen
            self.tableview.reloadData()
            option[0].backgroundColor = UIColor(hexString: "#4B4D4Dff")
            option[0].setTitleColor(UIColor.white, for: .normal)
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
            
            var arr = [String]()
            var arr1 = [String]()
            var price : Int = 0
            var duration : Int = 0
            arr.removeAll()
            arr1.removeAll()
            for i in checked{
                arr.append(services[i].id)
                arr1.append(services[i].name)
                price = price + services[i].price
                for j in services[i].services{
                    if (j[1] == dataToPost.sharedManager.stylistId){
                        duration = duration + Int(j[0])!
                    }
                }
            }
            print("duration : \(duration) , price :\(price )")
            dataToPost.sharedManager.price = price
            dataToPost.sharedManager.duration = duration
            dataToPost.sharedManager.services = arr
            dataToPost.sharedManager.servicesNames = arr1
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "datePick")
            //self.present(vc!, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc!, animated:
                true)
            
            // !!-- CODE SNIPPET TO FETCH PRICE --!!
            
            
            
           
            
            
            
        }
    
    }
    @objc private func btnAction(sender: UIButton!){
     
    }
    
    
    
}


