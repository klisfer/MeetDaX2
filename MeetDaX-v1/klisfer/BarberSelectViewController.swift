//
//  BarberSelectViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 13/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//imageUrl

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase


class BarberSelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var barberName = [String]()
    let db = Firestore.firestore()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tabBar: UINavigationItem!
    @IBOutlet weak var TABLEVIEW: UITableView!
   
    @IBOutlet weak var viewScroll: UIView!
    
    
    @IBOutlet weak var barberPic: UIImageView!
    
    @IBOutlet weak var barbrName: UILabel!
    
    @IBOutlet weak var timeToPost: UILabel!
    
    @IBOutlet weak var dateToPost: UILabel!
    @IBOutlet var tableViewHeightLayout: NSLayoutConstraint!
    
    
    var Date : String? = ""
    var Time : String? = ""
    
    var stylistData = [stylist]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        
        
        let img = UIImage(named: "card-bg")
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
      //  viewScroll.frame = CGRect(x: 0, y: 0 , width: screenWidth, height: CGFloat(151*(delegate.selserv_stylists_name.count) + 300))
        TABLEVIEW.frame = CGRect(x: 250, y: 0 , width: screenWidth, height: CGFloat(150*(delegate.selserv_stylists_name.count) + 200))
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#4B4D4Dff")
        //button.translatesAutoresizingMaskIntoConstraints = false
        //button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.frame = CGRect(x: 25, y: 270 + ((self.delegate.selserv_stylists_name.count)*150), width: Int(screenWidth-50), height: 50)
        //button.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        //button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.layer.cornerRadius = 6
        //self.viewScroll.addSubview(button)
        
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        TABLEVIEW.reloadData()
       
        
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector");
        UINavigationBar.appearance().barTintColor = .black
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("Skip", for: .normal)
        btn1.setTitleColor(UIColor(hexString: "#ffffffff"), for: .normal)
        btn1.frame = CGRect(x:0, y: 44 , width: 30, height: 30)
        btn1.addTarget(self, action: #selector(skipAction),for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        if(dataToPost.sharedManager.updateId != nil){
            self.tabBar.rightBarButtonItem = item1;
            
        }
    }
    override func viewDidLayoutSubviews() {
        
        TABLEVIEW.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.isScrollEnabled = false
        return (objects.sharedManager.stylistData.count)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarberSelectTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.barbername.text = (objects.sharedManager.stylistData[indexPath.row]).name
        cell.chooseBtn.tag = indexPath.row
        //cell.specialization.text = delegate.serviceFor[indexPath.row]
        cell.chooseBtn.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        let imgUrl = (objects.sharedManager.stylistData[indexPath.row]).imageUrl
        let url = URL(string: imgUrl)
        cell.barberimg.kf.setImage(with: url)
        
        
        return (cell)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarberSelectTableViewCell
        let img = UIImage(named: "card-bg")
        //card.backgroundColor = UIColor(patternImage: img!)
        cell.chooseBtn.backgroundColor = UIColor(patternImage: img!)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let tableViewHeight:CGFloat = CGFloat(151*(objects.sharedManager.stylistData.count));
        
        tableViewHeightLayout.constant = tableViewHeight

    }
    
    @objc private func skipAction(sender: UIButton){
      
        
        
        let update_id = dataToPost.sharedManager.updateId
        let index  =  dataToPost.sharedManager.updateIndex
        
        
        dataToPost.sharedManager.stylistId = objects.sharedManager.fetchedBookings[index!].stylistId
        dataToPost.sharedManager.stylistName = objects.sharedManager.fetchedBookings[index!].stylistName
        dataToPost.sharedManager.imgUrl = objects.sharedManager.fetchedBookings[index!].imgUrl
        
  
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "chooseService")
            //self.present(vc!, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc!, animated:
                true)
            
        
        
        
        
        
    }
    
    @objc private func btnSelected(sender: UIButton){
        // let sv = UIViewController.displaySpinner(onView: self.view)
        
        
        //delegate.row_no = sender.tag
        dataToPost.sharedManager.stylistName = objects.sharedManager.stylistData[sender.tag].name
        dataToPost.sharedManager.stylistId = objects.sharedManager.stylistData[sender.tag].id
        dataToPost.sharedManager.imgUrl = objects.sharedManager.stylistData[sender.tag].imageUrl
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "chooseService")
        //self.present(vc!, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc!, animated:
            true)
      
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
            self.tabBarController?.selectedIndex = 1
            
        }
        
        
        
    }
    private func fetch(){
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup")
        //self.present(vc!, animated: true, completion: nil)
        
        let storage = Storage.storage().reference()
        let database = Database.database().reference()
        
    }
    
    
    
    
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
