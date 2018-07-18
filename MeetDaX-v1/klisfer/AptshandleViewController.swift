//
//  AptshandleViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 09/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class AptshandleViewController: UIViewController {
    
    
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var db : Firestore!
    var formatter = DateFormatter()
    var aptDate = Date()
    var yourArray = [String]()
    let list = ["barber1" , "barber2" ,"barber3" ]
    var someDateTime : String!
    
    @IBOutlet weak var card1time: UILabel!
    @IBOutlet weak var card3time: UILabel!
    @IBOutlet weak var card2time: UILabel!
    
    
 
  
    
    @IBAction func btn(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        someDateTime = formatter.string(from: aptDate)
        
        db = Firestore.firestore()
        let user = Auth.auth().currentUser
        let mail = user?.email
        db.collection("events").whereField("email", isEqualTo: mail).getDocuments{ (snapshot, error) in
            if error != nil{
                print(error)
            }else{
                for document in (snapshot?.documents)!{
                    self.aptDate =  document.data()["startDate"] as! Date
                    self.someDateTime = self.formatter.string(from: self.aptDate)
                    
                    self.yourArray.append(self.someDateTime)
                    //print(document.data())
                     print("sdt:\(self.someDateTime) ")
                     //print("\(self.yourArray[0]) ")
                    
                }
             
            }
        }

    }
    
   

   

}
