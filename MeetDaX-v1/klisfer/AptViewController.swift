//
//  AptViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 08/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import Firebase
import FirebaseFirestore
class AptViewController: UIViewController {

    var db : Firestore!
    var formatter = DateFormatter()
    var aptDate = Date()
    var someDateTime : String!
   
    
    
    //@IBOutlet weak var card1datetime: UILabel!
    //@IBOutlet weak var card2datetime: UILabel!
    //@IBOutlet weak var card3datetime: UILabel!
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
                   // self.bookinDts.append(self.someDateTime)
                    print("\(self.someDateTime) ")
                }
                
            }
        }
    
    }
    
   
    
    
    
}
