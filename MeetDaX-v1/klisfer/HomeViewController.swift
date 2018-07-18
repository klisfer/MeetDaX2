//
//  HomeViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 28/02/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseFirestore
import SkyFloatingLabelTextField
import FirebaseStorage
class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderSelect.text = genders[row]
        self.view.endEditing(false)
    }
    
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var genders = ["Male", "Female", "Others"]
    //    var email = SkyFloatingLabelTextField()
    //    var password = UITextField()
    //    var fullname = SkyFloatingLabelTextField()
    //    var mobile = SkyFloatingLabelTextField()
    //    var gender = SkyFloatingLabelTextField()
    //    var age = SkyFloatingLabelTextField()
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var profilePic: UIImageView!
    var email = SkyFloatingLabelTextField()
    var password = SkyFloatingLabelTextField()
    var fullname = SkyFloatingLabelTextField()
    var mobile = SkyFloatingLabelTextField()
    var genderSelect = SkyFloatingLabelTextField()
    var gender = SkyFloatingLabelTextField()
    var age = SkyFloatingLabelTextField()
    var terms = UILabel()
    var SignUpPage = UIButton()
    let confirmpassword = SkyFloatingLabelTextField()
    //let db = Firestore.firestore()
    var servc : [String] = []
    let picker = UIPickerView()
    
    //MARK: Properties
    //@IBOutlet weak var uiProfilePic: UIImageView!
    //@IBOutlet weak var uiName: UILabel!
    // @IBOutlet weak var cust_img: UIImageView!
    
    @IBOutlet weak var viewScroll: UIView!
    
    //MARK: Actions
    @IBAction func didSignout(_ sender: Any) {
        //signout users from firebase
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // signout user of facebook
        FBSDKAccessToken.setCurrent(nil)
        
        //send user to login screen after signout
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : UIViewController =  mainStoryboard.instantiateViewController(withIdentifier: "LoginView")
        
        
        self.present(viewController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.delegate.event_service1)
        //print(self.delegate.event_service2)
        print(self.delegate.doc_id)
        mobile.delegate = self
        self.profilePic.image = self.delegate.profile_image
        self.view.backgroundColor = .white
        
        setupLayout()
        //get signedin user details
        let user = Auth.auth().currentUser
        if let user = user {
            // let name = user.displayName
            let email = user.email
        }
        
       
    }

    
    
    private func setupLayout(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        let user = Auth.auth().currentUser
        let mail = user?.email
        let name = user?.displayName
        
        //view
        
        
        self.viewScroll.backgroundColor = UIColor.clear
        
        //Label
        //descriptionTextView.frame = CGRect(x: 20, y: 100, width: screenWidth-40, height: 40)
        //
        //        descriptionTextView.text = "Create an Account"
        //        //descriptionTextView.font = UIFont(ofSize: 24)
        //        descriptionTextView.font = UIFont(name: "Helvetica", size: 24)
        //        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        //        descriptionTextView.textAlignment = .center
        //        descriptionTextView.isEditable = false
        //        descriptionTextView.isScrollEnabled = false
        //        descriptionTextView.textColor = UIColor(hexString: "#008F95ff")
        //
        //
        //        descriptionTextView.backgroundColor = UIColor.clear
        //        viewScroll.addSubview(descriptionTextView)
        //        descriptionTextView.topAnchor.constraint(equalTo: viewScroll.topAnchor, constant: 150).isActive = true
        //        descriptionTextView.centerXAnchor.constraint(equalTo: viewScroll.centerXAnchor).isActive = true
        //
        //
        //        //text Field email
        //        myImage.frame =  CGRect(x: (screenWidth - 0.15*screenHeight)/2, y: 200, width: 0.15*screenHeight , height: 0.15*screenHeight)
        //        myImage.contentMode = .scaleToFill
        //
        //        uploadBtn.frame =  CGRect(x: (screenWidth - 0.15*screenHeight)/2 , y: 200 + 0.15*screenHeight , width: 0.15*screenHeight , height: 40)
        //        uploadBtn.layer.shadowColor = UIColor.black.cgColor
        //        uploadBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        //        uploadBtn.layer.shadowRadius = 5
        //        uploadBtn.layer.shadowOpacity = 1.0
        //        uploadBtn.layer.cornerRadius = 2
        //        uploadBtn.backgroundColor = UIColor(hexString: "#20BFC6ff")
        //        viewScroll.addSubview(uploadBtn)
        
        
//        email.frame = CGRect(x: 20, y: 390, width: screenWidth-40, height: 40)
//        
//        //email.placeholder = "Email"
//        email.font = UIFont.systemFont(ofSize: 15)
//        //email.borderStyle = UITextBorderStyle.roundedRect
//        //email.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
//        email.attributedPlaceholder = NSAttributedString(string: mail!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#95989Aff")])
//        //email.autocorrectionType = UITextAutocorrectionType.no
//        email.keyboardType = UIKeyboardType.default
//        email.returnKeyType = UIReturnKeyType.done
//        email.tintColor = .cyan
//        email.clearButtonMode = UITextFieldViewMode.whileEditing;
//        email.contentVerticalAlignment = UIControlContentVerticalAlignment.center
//        viewScroll.addSubview(email)
//        email.tintColor = UIColor(hexString: "#20BFC6ff")
//        email.lineHeight = 1.0 // bottom line height in points
//        email.selectedLineHeight = 2.0
//        email.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
//        email.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
//        email.textColor = UIColor(hexString: "#000000ff")!
//        email.isUserInteractionEnabled = false
        
        
        //text Field password
        //
        //        password.frame = CGRect(x: 20, y: 450, width: screenWidth-40, height: 40)
        //        //password.placeholder = "Password"
        //        password.font = UIFont.systemFont(ofSize: 15)
        //        // password.borderStyle = UITextBorderStyle.roundedRect
        //        password.autocorrectionType = UITextAutocorrectionType.no
        //        password.keyboardType = UIKeyboardType.default
        //        password.returnKeyType = UIReturnKeyType.done
        //        password.clearButtonMode = UITextFieldViewMode.whileEditing;
        //        password.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //        // password.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        //        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        //        viewScroll.addSubview(password)
        //        password.tintColor = UIColor(hexString: "#20BFC6ff")
        //        password.lineHeight = 1.0 // bottom line height in points
        //        password.selectedLineHeight = 2.0
        //        password.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        //        password.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        //        password.textColor = UIColor(hexString: "#000000ff")!
        //        password.title = "PASSWORD"
        //        //text Field confirm password
        //
        //        confirmpassword.frame = CGRect(x: 20, y: 510, width: screenWidth-40, height: 40)
        //        //confirmpassword.placeholder = "Confirm Password"
        //        confirmpassword.font = UIFont.systemFont(ofSize: 15)
        //        //confirmpassword.borderStyle = UITextBorderStyle.roundedRect
        //        confirmpassword.autocorrectionType = UITextAutocorrectionType.no
        //        confirmpassword.keyboardType = UIKeyboardType.default
        //        confirmpassword.returnKeyType = UIReturnKeyType.done
        //        confirmpassword.clearButtonMode = UITextFieldViewMode.whileEditing;
        //        confirmpassword.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //        viewScroll.addSubview(confirmpassword)
        //        // confirmpassword.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        //        confirmpassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        //        confirmpassword.tintColor = UIColor(hexString: "#20BFC6ff")
        //        confirmpassword.lineHeight = 1.0 // bottom line height in points
        //        confirmpassword.selectedLineHeight = 2.0
        //        confirmpassword.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        //        confirmpassword.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        //        confirmpassword.textColor = UIColor(hexString: "#000000ff")!
        //        confirmpassword.title = "Confirm Password"
        //        //text Field full name
        
        fullname.frame = CGRect(x: 20, y: 450, width: screenWidth-40, height: 40)
        //fullname.placeholder = "First Name"
        fullname.font = UIFont.systemFont(ofSize: 15)
        //fullname.borderStyle = UITextBorderStyle.roundedRect
        fullname.autocorrectionType = UITextAutocorrectionType.no
        fullname.keyboardType = UIKeyboardType.default
        fullname.returnKeyType = UIReturnKeyType.done
        fullname.clearButtonMode = UITextFieldViewMode.whileEditing;
        fullname.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        viewScroll.addSubview(fullname)
        // fullname.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        fullname.attributedPlaceholder = NSAttributedString(string: name! , attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        //text Field Mobile
        fullname.tintColor = UIColor(hexString: "#20BFC6ff")
        fullname.lineHeight = 1.0 // bottom line height in points
        fullname.selectedLineHeight = 2.0
        fullname.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        fullname.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        fullname.textColor = UIColor(hexString: "#000000ff")!
        fullname.isUserInteractionEnabled = false
        
        
        
        
        mobile.frame = CGRect(x: 20, y: 510, width: screenWidth-40, height: 40)
        mobile.placeholder = "Mobile Number"
        mobile.font = UIFont.systemFont(ofSize: 15)
        //mobile.borderStyle = UITextBorderStyle.roundedRect
        mobile.autocorrectionType = UITextAutocorrectionType.no
        mobile.keyboardType = UIKeyboardType.default
        mobile.returnKeyType = UIReturnKeyType.done
        mobile.clearButtonMode = UITextFieldViewMode.whileEditing;
        mobile.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        viewScroll.addSubview(mobile)
        // mobile.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        mobile.attributedPlaceholder = NSAttributedString(string: "Mobile Number", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        mobile.tintColor = UIColor(hexString: "#20BFC6ff")
        mobile.lineHeight = 1.0 // bottom line height in points
        mobile.selectedLineHeight = 2.0
        mobile.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        mobile.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        mobile.textColor = UIColor(hexString: "#000000ff")!
        mobile.title = "Mobile Number"
        
        
        //text Field gender
        //
        //        gender.frame = CGRect(x: 20, y: 570, width: screenWidth-40, height: 40)
        //        //gender.placeholder = "Last Name"
        //        gender.font = UIFont.systemFont(ofSize: 15)
        //        // gender.borderStyle = UITextBorderStyle.roundedRect
        //        gender.autocorrectionType = UITextAutocorrectionType.no
        //        gender.keyboardType = UIKeyboardType.default
        //        gender.returnKeyType = UIReturnKeyType.done
        //        gender.clearButtonMode = UITextFieldViewMode.whileEditing;
        //        gender.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //        viewScroll.addSubview(gender)
        //        //  gender.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        //        gender.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        //        gender.tintColor = UIColor(hexString: "#20BFC6ff")
        //        gender.lineHeight = 1.0 // bottom line height in points
        //        gender.selectedLineHeight = 2.0
        //        gender.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        //        gender.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        //        gender.textColor = UIColor(hexString: "#000000ff")!
        //        gender.title = "Last Name"
        
        
        //text Field age
        
        age.frame = CGRect(x: 20, y: 570, width: screenWidth-40, height: 40)
        //age.placeholder = "Age"
        age.font = UIFont.systemFont(ofSize: 15)
        //age.borderStyle = UITextBorderStyle.roundedRect
        age.autocorrectionType = UITextAutocorrectionType.no
        age.keyboardType = UIKeyboardType.default
        age.returnKeyType = UIReturnKeyType.done
        age.clearButtonMode = UITextFieldViewMode.whileEditing;
        age.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        viewScroll.addSubview(age)
        //  age.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        age.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        age.tintColor = UIColor(hexString: "#20BFC6ff")
        age.lineHeight = 1.0 // bottom line height in points
        age.selectedLineHeight = 2.0
        age.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        age.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        age.textColor = UIColor(hexString: "#000000ff")!
        age.title = "Age"
        //gender picker
        
        picker.delegate = self
        picker.dataSource = self
        genderSelect.inputView = picker
        genderSelect.frame = CGRect(x: 20, y: 630, width: screenWidth-40, height: 40)
        //genderSelect.placeholder = "Gender"
        genderSelect.font = UIFont.systemFont(ofSize: 15)
        genderSelect.borderStyle = UITextBorderStyle.none
        viewScroll.addSubview(genderSelect)
        genderSelect.textColor = UIColor(hexString: "#000000ff")
        //genderSelect.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        genderSelect.attributedPlaceholder = NSAttributedString(string: "Gender", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#95989Aff")])
        genderSelect.tintColor = UIColor(hexString: "#20BFC6ff")
        genderSelect.lineHeight = 1.0 // bottom line height in points
        genderSelect.selectedLineHeight = 2.0
        genderSelect.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        genderSelect.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        genderSelect.textColor = UIColor(hexString: "#000000ff")!
        genderSelect.title = "GENDER"
        genderSelect.layer.masksToBounds = true
        
        
        terms.frame = CGRect(x: 20, y: 670, width: screenWidth-40, height: 40)
        terms.text = "By creating a profile you agree to the terms and conditions of Barbershop"
        terms.textColor = UIColor.black
        terms.font = UIFont.systemFont(ofSize: 12)
        terms.backgroundColor = UIColor.clear
        terms.textAlignment = .left
        terms.numberOfLines = 0
        
        viewScroll.addSubview(terms)
        //checkbox
        
        
        
        
        //agree terms
        let agree = UITextView()
        agree.frame = CGRect(x: 65, y: 740, width: screenWidth-85, height: 60)
        agree.text = "I agree to receive news, exclusive offers & more from barbershop. You can unsubscribe any time"
        agree.font = UIFont.systemFont(ofSize: 12)
        //agree.translatesAutoresizingMaskIntoConstraints = false
        agree.textAlignment = .center
        agree.isEditable = false
        agree.isScrollEnabled = false
        agree.textColor = .black
        agree.backgroundColor = UIColor.clear
        agree.textAlignment = .left
        viewScroll.addSubview(agree)
        //agree.numberOfLines = 0
        
        //button for SignUp
        let signupbutton = UIButton(frame: CGRect(x: 20, y: 810 , width: screenWidth - 40 , height: 50))
        signupbutton.setTitle("SIGN UP", for: UIControlState.normal)
        signupbutton.tintColor = UIColor.black
        signupbutton.backgroundColor = UIColor(hexString: "#20BFC6ff")
        signupbutton.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
        signupbutton.layer.shadowColor = UIColor.black.cgColor
        signupbutton.layer.shadowOffset = CGSize(width: 5, height: 5)
        signupbutton.layer.shadowRadius = 6
        signupbutton.layer.shadowOpacity = 0.4
        signupbutton.layer.cornerRadius = 6
        viewScroll.addSubview(signupbutton)
        
        
        SignUpPage.frame = CGRect(x: 20, y: 870, width: screenWidth-40, height: 40)
        SignUpPage.setTitle("Don't have an account? Sign Up", for: UIControlState.normal)
        SignUpPage.backgroundColor = UIColor.clear
        //SignUpPage.font = UIFont.systemFont(ofSize: 12)
        
//        SignUpPage.textAlignment = .center
//        SignUpPage.numberOfLines = 0
        SignUpPage.addTarget(self, action: #selector(LoginPage),for: .touchUpInside)
        viewScroll.addSubview(SignUpPage)
        
    }
    
    @objc private func LoginPage(){
        
    }
    
    @objc private func buttonAction(){
        
        
        if genderSelect.text == "" || mobile.text == "" || age.text == ""  {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "All Fields are mandatory", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            uploadMedia() { (url) in


            let spin = UIViewController.displaySpinner(onView: self.view)
            var ref: DocumentReference? = nil
            let user = Auth.auth().currentUser
            let name = user?.displayName
            let mail = user?.email
            var myStringArr = name?.components(separatedBy: " ")
            let fname = myStringArr![0]
            let lname = myStringArr![1]
            let userID = Auth.auth().currentUser!.uid
            ref = self.db.collection("Customers").addDocument(data: [
                "email": mail,
                "firstName": fname,
                "lastName": lname,
                "phone" :  self.mobile.text!,
                "age" : self.age.text!,
                "gender" : self.genderSelect.text!,
                "uid" : userID,
                "imageUrl" : url!
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    let alertController = UIAlertController(title: "Error", message: "The account could not be created", preferredStyle: .alert)

                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)

                    self.present(alertController, animated: true, completion: nil)

                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    UIViewController.removeSpinner(spinner: spin)
                    
                }
            }
        }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let str = Auth.auth().currentUser?.uid as! String
        let storageRef = Storage.storage().reference().child("customers/\(str).png")
        if let uploadData = UIImagePNGRepresentation(self.profilePic.image!) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
            
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                }
            
            }
        }
        
    }
    
    
}
