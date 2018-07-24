//
//  BarberSelectViewController1.swift
//  klisfer
//
//  Created by aayush chaubey on 24/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase
import JSSAlertView
class BarberSelectViewController1: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var list = ["abc" , "def" , "fgh" , "dff" , "wer"]
    
    var barberName = [String]()
    let db = Firestore.firestore()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var tabBar: UINavigationItem!
    @IBOutlet weak var TABLEVIEW: UITableView!
    @IBOutlet weak var serv1: UILabel!
    @IBOutlet weak var serv2: UILabel!
    @IBOutlet weak var viewScroll: UIView!
    
    @IBOutlet weak var card: CardView!
    @IBOutlet weak var barberPic: UIImageView!
    
    @IBOutlet weak var barbrName: UILabel!
    
    @IBOutlet weak var timeToPost: UILabel!
    @IBOutlet var tableviewHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var dateToPost: UILabel!
    var Date : String? = ""
    var Time : String? = ""
    
    var stylistData = [stylist]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.sharedManager.stylistDataF2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarberSelect1TableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.barbername.text = (objects.sharedManager.stylistDataF2[indexPath.row]).name
        cell.chooseBtn.tag = indexPath.row
        //cell.specialization.text = delegate.serviceFor[indexPath.row]
        cell.chooseBtn.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        let imgUrl = (objects.sharedManager.stylistDataF2[indexPath.row]).imageUrl
        let url = URL(string: imgUrl)
        cell.barberimg.kf.setImage(with: url)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarberSelectTableViewCell
        let img = UIImage(named: "card-bg")
        //card.backgroundColor = UIColor(patternImage: img!)
        cell.chooseBtn.backgroundColor = UIColor(patternImage: img!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        print("cahl be \(dataToPost.sharedManager.servicesNames)")
        
        if(dataToPost.sharedManager.services.count == 1){
           self.serv1.text = dataToPost.sharedManager.servicesNames[0]
        }else if(dataToPost.sharedManager.services.count == 2){
            
            self.serv1.text = dataToPost.sharedManager.servicesNames[0]
            self.serv2.text = dataToPost.sharedManager.servicesNames[1]
            
        }
        
      
        
        
       
        
        let img = UIImage(named: "card-bg")
        card.backgroundColor = UIColor(patternImage: img!)
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        
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
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let tableViewHeight:CGFloat = CGFloat(151*(objects.sharedManager.stylistDataF2.count));
        
        tableviewHeightConst.constant = tableViewHeight
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        TABLEVIEW.reloadData()
     
        
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector");
        UINavigationBar.appearance().barTintColor = .black
        
        
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("Skip", for: .normal)
        btn1.setTitleColor(UIColor(hexString: "#ffffffff"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 44 , width: 30, height: 30)
        btn1.addTarget(self, action: #selector(skipAction),for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        if(self.delegate.update_id != nil){
            self.tabBar.rightBarButtonItem = item1;
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        TABLEVIEW.reloadData()
    }
    
    @objc private func skipAction(sender: UIButton){
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        delegate.row_no = sender.tag
        let update_id = delegate.update_id
        let index  = delegate.doc_id.index(of: update_id!)
        
        delegate.stylist = delegate.event_stylists_name[index!]
        delegate.stylist_id = delegate.event_stylists_id[index!]
        let stylist_id = delegate.event_stylists_id[index!]
        
        delegate.stylist_pic_url = delegate.event_stylists_pic_url[index!]
        
        let imgUrl = delegate.barberPicUrl[sender.tag]
        let url = URL(string: imgUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { (data, response , error) in
            if error != nil{
                print (error)
                return
            }
            DispatchQueue.main.async{
                let imahe : UIImage = UIImage(data: data!)!
                self.delegate.stylistPic["selected"] = imahe
                
            }
            
        }).resume()
        
        var index2 = self.delegate.uid_stylists.index(of: stylist_id)
        var array : [String] = self.delegate.barberServices[index2!]
        
        self.delegate.servProv.removeAll()
        self.delegate.servProvId.removeAll()
        
        for i in array{
            db.collection("services").document(i).getDocument { (document, error) in
                if let document = document {
                    
                    self.delegate.servProv.append(document.data()!["name"] as! String)
                    self.delegate.servProvId.append(i)
                    
                } else {
                    
                }
            }
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIViewController.removeSpinner(spinner: sv)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "chooseService")
            //self.present(vc!, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc!, animated:
                true)
            
        }
        
        
        
        
    }
    
    @objc private func btnSelected(sender: UIButton){
        // let sv = UIViewController.displaySpinner(onView: self.view)
        var duration : Int = 0
        for i in objects.sharedManager.servicesTemp{
            for j in i.services{
                if(j[1] == objects.sharedManager.stylistDataF2[sender.tag].id){
                    duration = duration + Int(j[0])!
                }
                
            }
        }
        
        //delegate.row_no = sender.tag
        dataToPost.sharedManager.stylistName = objects.sharedManager.stylistDataF2[sender.tag].name
        dataToPost.sharedManager.stylistId = objects.sharedManager.stylistDataF2[sender.tag].id
        dataToPost.sharedManager.imgUrl = objects.sharedManager.stylistDataF2[sender.tag].imageUrl
        dataToPost.sharedManager.duration = duration
        print("duration == \(duration)")
        let imgUrl = objects.sharedManager.stylistDataF2[sender.tag].imageUrl
        let url = URL(string: imgUrl)
        barberPic.kf.setImage(with: url)
        barbrName.text = objects.sharedManager.stylistDataF2[sender.tag].name;
        let calendar = dataToPost.sharedManager.startDate
        let Later = TimeInterval(dataToPost.sharedManager.duration.minutes)
        let endDate = calendar?.addingTimeInterval(Later)
        dataToPost.sharedManager.endDate = endDate
        
        
        // start time and end time
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "HH:mm"
        let endTime = dateFormatter3.string(from: dataToPost.sharedManager.endDate!)
        let startTime  = dateFormatter3.string(from: dataToPost.sharedManager.startDate!)
        
        // date for posting
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter2.string(from: dataToPost.sharedManager.startDate!)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "chooseService")
//        //self.present(vc!, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc!, animated:
//            true)
        if (dataToPost.sharedManager.updateId == nil){
            db.collection("bookings").addDocument(data: [
                "customer"   : Auth.auth().currentUser?.uid,
                "stylist"    : dataToPost.sharedManager.stylistId,
                "services"   : dataToPost.sharedManager.services,
                "date"       : date,
                "imageUrl"   : dataToPost.sharedManager.imgUrl,
                "duration"   : dataToPost.sharedManager.duration,
                "endTime"    : endTime,
                "startTime"  : startTime,
                "price"      : dataToPost.sharedManager.price,
                "eid"        : "",
                "how_often"  : "",
                "id"         : "",
                "comments"   : "",

            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                    
                    func myCallback2() {
                        dataToPost.sharedManager.switchToEventFlag = true
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    var customIcon2 = UIImage(named: "download")
                    var alertview = JSSAlertView().show(self,
                                                        title: "BOOKING FAILED",
                                                        text: "Try again",
                                                        iconImage: customIcon2
                    )
                    alertview.addAction(myCallback2) // Method to run after dismissal
                    alertview.setTitleFont("ClearSans-Bold") // Title font
                    alertview.setTextFont("ClearSans") // Alert body text font
                    alertview.setButtonFont("ClearSans-Light") // Button text font
                } else {
                    
                    func myCallback() {
                        dataToPost.sharedManager.switchToEventFlag = true
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    var customIcon = UIImage(named: "green")
                    var alertview = JSSAlertView().show(self,
                                                        title: "SUCCESS",
                                                        text: "Booking Confirmed",
                                                        iconImage: customIcon
                    )
                    alertview.addAction(myCallback) // Method to run after dismissal
                    alertview.setTitleFont("ClearSans-Bold") // Title font
                    alertview.setTextFont("ClearSans") // Alert body text font
                    alertview.setButtonFont("ClearSans-Light") // Button text font
                    dataToPost.sharedManager.stylistId = ""
                    dataToPost.sharedManager.stylistName = ""
                    dataToPost.sharedManager.services.removeAll()
                    dataToPost.sharedManager.servicesNames.removeAll()
                    dataToPost.sharedManager.startDate = nil
                    dataToPost.sharedManager.imgUrl = ""
                    dataToPost.sharedManager.duration = 0
                    dataToPost.sharedManager.endDate = nil
                    dataToPost.sharedManager.price = 0
                    
                    
                }
            }
            
        }else{
            db.collection("bookings").document(dataToPost.sharedManager.updateId!).updateData([
                "customer"   : Auth.auth().currentUser?.uid,
                "stylist"    : dataToPost.sharedManager.stylistId,
                "services"   : dataToPost.sharedManager.services,
                "date"       : date,
                "imageUrl"   : dataToPost.sharedManager.imgUrl,
                "duration"   : dataToPost.sharedManager.duration,
                "endTime"    : endTime,
                "startTime"  : startTime,
                "price"      : dataToPost.sharedManager.price,
                "eid"        : "",
                "how_often"  : "",
                "id"         : "",
                "comments"   : "",
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                    
                    func myCallback2() {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    var customIcon2 = UIImage(named: "download")
                    var alertview = JSSAlertView().show(self,
                                                        title: "UPDATE FAILED",
                                                        text: "Try again",
                                                        iconImage: customIcon2
                    )
                    alertview.addAction(myCallback2) // Method to run after dismissal
                    alertview.setTitleFont("ClearSans-Bold") // Title font
                    alertview.setTextFont("ClearSans") // Alert body text font
                    alertview.setButtonFont("ClearSans-Light") // Button text font
                } else {
                    func myCallback() {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                        self.present(vc!, animated: true, completion: nil)
                    }
                    var customIcon = UIImage(named: "green")
                    var alertview = JSSAlertView().show(self,
                                                        title: "SUCCESS",
                                                        text: "Booking Updated Successfully",
                                                        iconImage: customIcon
                    )
                    alertview.addAction(myCallback) // Method to run after dismissal
                    alertview.setTitleFont("ClearSans-Bold") // Title font
                    alertview.setTextFont("ClearSans") // Alert body text font
                    alertview.setButtonFont("ClearSans-Light") // Button text font
                    dataToPost.sharedManager.updateId = nil
                    dataToPost.sharedManager.updateIndex = nil
                    print("Document successfully updated!")
                    
                }
            }
        }
        
        
        
        
        //--------------//
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //UIViewController.removeSpinner(spinner: sv)
            //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
            //            //self.present(vc!, animated: true, completion: nil)
            //            self.navigationController?.pushViewController(vc!, animated:
            //                true)
            self.tabBarController?.selectedIndex = 1
            
        }
        
    }
    
    private func fetch(){
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup")
        //self.present(vc!, animated: true, completion: nil)
        
        let storage = Storage.storage().reference()
        let database = Database.database().reference()
        
    }
    
    
}
