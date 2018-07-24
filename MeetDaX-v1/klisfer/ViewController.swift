//
//  ViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 28/02/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore
import FontAwesome_swift
import Material
import SkyFloatingLabelTextField
import Alamofire



class ViewController: UIViewController,UITextFieldDelegate {
    
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var dbt : Firestore!
    var loginButton: FBSDKLoginButton = FBSDKLoginButton()
    var googleButton : GIDSignInButton = GIDSignInButton()
    var phone = SkyFloatingLabelTextField()
    var password = SkyFloatingLabelTextField()
    var loginbtn = UIButton()
    @objc var signup = UIButton()
    var fbgogl = UITextView()
    var frgt = UITextView()
    var fbbtn = UIButton()
    var goglbtn = UIButton()
    var logo = UIImageView()
    
    @IBOutlet weak var aiLoadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                // move the user to homescreen
                self.fetchingData3()
                self.fetchingData(completion : {  success in
                
                
                    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController : UIViewController =  mainStoryboard.instantiateViewController(withIdentifier: "TabBar")
                    self.present(homeViewController, animated: true, completion: nil)
                
                })
                

            }
        }
        
        
        //self.setupFacebookButtons()
        //self.setupGoogleButtons()
        dbt = Firestore.firestore()
        setupLayout()
        print(view.frame.height)
        //        GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        //checks whether user is logged in or not
        //setupFacebookButtons()
        
        
        
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        loginbtn.applyGradient(colours: [UIColor(hexString: "#4D58E2"), UIColor(hexString: "#121953")], locations: [ 0.5, 1])
        loginbtn.layer.masksToBounds = true
     
    }
    private func setupLayout(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        phone.frame = CGRect(x: 20, y: (0.50)*view.frame.height , width: screenWidth-40, height: 45)
        phone.attributedPlaceholder = NSAttributedString(string: "Mobile Number", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#95989Aff") , NSAttributedStringKey.font : UIFont(name: "Roboto-Light", size: 28)! ])
        //email.autocorrectionType = UITextAutocorrectionType.no
        phone.keyboardType = UIKeyboardType.default
        phone.returnKeyType = UIReturnKeyType.done
        phone.clearButtonMode = UITextFieldViewMode.whileEditing;
        phone.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        phone.tintColor = UIColor(hexString: "#4D58E2ff")
        phone.lineHeight = 1.0 // bottom line height in points
        phone.selectedLineHeight = 2.0

        phone.selectedTitleColor = UIColor(hexString: "#4D58E2ff")!
        phone.selectedLineColor = UIColor(hexString: "#4D58E2ff")!
        phone.textColor = UIColor.white
        phone.title = "Mobile no."
        view.addSubview(phone)
        
        
//
//        password.frame = CGRect(x: 20, y: screenHeight - 360 , width: screenWidth-40, height: 45)
//        //password.placeholder = "Password"
//        password.font = UIFont.systemFont(ofSize: 15)
//        //password.borderStyle = UITextBorderStyle.roundedRect
//        password.attributedPlaceholder = NSAttributedString(string: "Password",
//                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#95989Aff")])
//        password.textColor = UIColor.white
//        password.autocorrectionType = UITextAutocorrectionType.no
//        password.keyboardType = UIKeyboardType.default
//        password.returnKeyType = UIReturnKeyType.done
//        password.clearButtonMode = UITextFieldViewMode.whileEditing;
//        password.contentVerticalAlignment = UIControlContentVerticalAlignment.center
//        password.tintColor = UIColor(hexString: "#4D58E2ff")
//        //password.textColor = UIColor.mf_veryDarkGray()
//        password.title = "Password"
//        password.lineHeight = 1.0 // bottom line height in points
//        password.selectedLineHeight = 2.0
//        password.selectedTitleColor = UIColor(hexString: "#4D58E2ff")!
//        password.selectedLineColor = UIColor(hexString: "#4D58E2ff")!
//        view.addSubview(password)
//
        
        loginbtn.frame = CGRect(x: 20, y: (0.65)*view.frame.height , width: screenWidth-40, height: 50)
        loginbtn.backgroundColor = UIColor(hexString: "#1C92AFff")
        loginbtn.layer.shadowColor = UIColor.black.cgColor
        loginbtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        loginbtn.layer.shadowRadius = 2
        loginbtn.layer.shadowOpacity = 1.0
        loginbtn.setTitle("LOG IND", for: UIControlState.normal)
        loginbtn.tintColor = UIColor.black
        
        loginbtn.layer.cornerRadius = 6
        loginbtn.addTarget(self, action: #selector(loginfu),for: .touchUpInside)
        view.addSubview(loginbtn)
        
        
        
        
        signup.frame = CGRect(x: 20, y: (0.75)*view.frame.height , width: screenWidth-40, height: 50)
        signup.backgroundColor = UIColor.clear
        signup.setTitle("Ny på Barbershop.dk? Opret konto", for: UIControlState.normal)
        signup.tintColor = UIColor.black
        signup.addTarget(self, action: #selector(check),for: .touchUpInside)
        view.addSubview(signup)
//
//        fbgogl.frame = CGRect(x: 20, y: screenHeight - 150 , width: screenWidth-40, height: 30)
//        fbgogl.text = "Login/Signup with Facebook/Google+"
//        fbgogl.textColor = .white
//        fbgogl.textAlignment = .center
//        fbgogl.backgroundColor = UIColor.clear
//        fbgogl.font = UIFont.systemFont(ofSize: 17)
//        view.addSubview(fbgogl)
//
//
        
//        fbbtn.frame = CGRect(x: 20, y: view.frame.height-100, width: view.frame.width/2 - 40, height: 50)
//        fbbtn.backgroundColor = UIColor(hexString: "#3B5998ff")
//        fbbtn.layer.shadowColor = UIColor.black.cgColor
//        fbbtn.layer.shadowOffset = CGSize(width: 5, height: 5)
//        fbbtn.layer.shadowRadius = 5
//        fbbtn.layer.shadowOpacity = 1.0
//        //fbbtn.setTitle("FACEBOOK", for: UIControlState.normal)
//        fbbtn.tintColor = UIColor.black
//        fbbtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 15)
//        fbbtn.setTitle(String.fontAwesomeIcon(name: .facebook) + "  " + "FACEBOOK", for: .normal)
//        fbbtn.layer.cornerRadius = 6
//        fbbtn.addTarget(self, action: #selector(fbBtnLogin),for: .touchUpInside)
//        view.addSubview(fbbtn)
//
//        goglbtn.frame = CGRect(x:view.frame.width/2 + 16 , y: view.frame.height-100, width: view.frame.width/2 - 40, height: 50)
//        goglbtn.backgroundColor = UIColor(hexString: "#db3236ff")
//        goglbtn.layer.shadowColor = UIColor.black.cgColor
//        goglbtn.layer.shadowOffset = CGSize(width: 5, height: 5)
//        goglbtn.layer.shadowRadius = 5
//        goglbtn.layer.shadowOpacity = 1.0
//
//        goglbtn.tintColor = UIColor.black
//        goglbtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 15)
//        goglbtn.setTitle(String.fontAwesomeIcon(name: .googlePlus) + " " + " GOOGLE" , for: .normal)
//        goglbtn.layer.cornerRadius = 6
//        goglbtn.addTarget(self, action: #selector(googleLogin),for: .touchUpInside)
//        view.addSubview(goglbtn)
        
        var image: UIImage = UIImage(named: "Logo_Salon5avenue-white")!
        logo = UIImageView(image: image)
        logo.frame = CGRect(x: (view.frame.width - (2/7)*view.frame.height)/2,y: (0.1125)*view.frame.height ,width: (2/7)*view.frame.height ,height: (1/7)*view.frame.height )
        
        view.addSubview(logo)
        
    }

  
    
    
    
    
    
    
    // don't have an account button action
    @objc func check(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup")
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    
    // fb login button action

    
    
    
    
    @objc private func loginfu(sender: Any){
        
        if self.phone.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a mobile number.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            PhoneAuthProvider.provider().verifyPhoneNumber(phone.text! , uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                // Store verificationID
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                customerDetails.sharedManager1.mobileNumber = self.phone.text!
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "otp")
                self.present(vc!, animated: true, completion: nil)

            }
      
        }
        
    }
    
    //segue to otp page.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if phone.isFirstResponder == true {
            phone.placeholder = nil
        }
    }
    
    //facebook button
        //login with google is handled in AppDelegate
    /*@objc func buttonAction(){
     if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
     self.present(vc!, animated: true, completion: nil)
     }
     }*/
    
    
    
    
    
}




