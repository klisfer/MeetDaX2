//
//  accountViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 27/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import FirebaseFirestore
import ChameleonFramework
import FBSDKCoreKit
import GoogleSignIn

class accountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 1.0)
        //UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDetails()
    }
    override func viewWillDisappear(_ animated: Bool) {
        setDetails()
    }
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    @IBOutlet weak var viewScroll: UIView!
    var fName = SkyFloatingLabelTextField()
    var lName = SkyFloatingLabelTextField()
    var email = SkyFloatingLabelTextField()
    var mobile = SkyFloatingLabelTextField()
   // var gender = SkyFloatingLabelTextField()
    
    
    
   
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var genderField: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
   
   
    
    @IBOutlet weak var icon1: UILabel!
   
    @IBOutlet weak var iconGender: UILabel!
    @IBOutlet weak var iconAge: UILabel!
    @IBOutlet weak var iconPhone: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
   
    
    
    private func setDetails(){
        //self.profilePic.image = self.delegate.cust_image["selected"]
        self.name.text = ("\(customerDetails.sharedManager1.firstName) \(customerDetails.sharedManager1.lastName)")
        
        self.phone.text = customerDetails.sharedManager1.mobileNumber
        self.genderField.text = customerDetails.sharedManager1.gender
        
        let now = Date()
        let birthday: Date = customerDetails.sharedManager1.age!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        var Age = String(age)
        self.age.text = Age
        let url = customerDetails.sharedManager1.imgUrl
        let imgUrl = URL(string: url)
        self.profilePic.kf.setImage(with: imgUrl)
        
    }
    
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        
        let user = Auth.auth().currentUser
       
        user?.delete { error in
            if let error = error {
              print("An error happened")
            } else {
              print("Account deleted")
            }
        }
        
        db.collection("Customers").document(customerDetails.sharedManager1.docID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
       
        logouts()
    
    
    }
    
    
    private func setupLayout(){
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        

        icon1.font = UIFont.fontAwesome(ofSize: 30)
        icon1.text = String.fontAwesomeIcon(name: .user)
        
        iconPhone.font = UIFont.fontAwesome(ofSize: 30)
        iconPhone.text = String.fontAwesomeIcon(name: .phone)
        
        iconGender.font = UIFont.fontAwesome(ofSize: 30)
        if(genderField.text == "Male"){
         iconGender.text = String.fontAwesomeIcon(name: .male)
        }else {
         iconGender.text = String.fontAwesomeIcon(name: .female)
        }
        
        iconAge.font = UIFont.fontAwesome(ofSize: 30)
        iconAge.text = String.fontAwesomeIcon(name: .genderless)
        
        
        logoutBtn.layer.shadowColor = UIColor.black.cgColor
        logoutBtn.layer.shadowOffset = CGSize(width: 3, height: 3)
        logoutBtn.layer.shadowRadius = 3
        logoutBtn.layer.shadowOpacity = 0.4
        logoutBtn.layer.cornerRadius = 6
        logoutBtn.backgroundColor = UIColor.flatBlack
        logoutBtn.addTarget(self, action: #selector(logout),for: .touchUpInside)

        
    }
    
    @objc func logout(){
        //signout users from firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // signout user of facebook
      
        
        //send user to login screen after signout
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : UIViewController =  mainStoryboard.instantiateViewController(withIdentifier: "LoginView")
        
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    private func logouts(){
        //signout users from firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // signout user of facebook
        
        
        //send user to login screen after signout
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : UIViewController =  mainStoryboard.instantiateViewController(withIdentifier: "LoginView")
        
        
        self.present(viewController, animated: true, completion: nil)
    }


}
