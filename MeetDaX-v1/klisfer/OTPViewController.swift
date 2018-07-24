//
//  OTPViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 15/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import FirebaseAuth
import FirebaseFirestore

class OTPViewController: UIViewController {
    var otp = SkyFloatingLabelTextField()
    var loginbtn = UIButton()
    let verificationID = String()
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
       setupLayout()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        loginbtn.applyGradient(colours: [UIColor(hexString: "#4D58E2"), UIColor(hexString: "#121953")], locations: [ 0.5, 1])
        loginbtn.layer.masksToBounds = true
        
    }

    
    private func setupLayout(){
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        otp.frame = CGRect(x: 20, y: 350 , width: screenWidth-40, height: 45)
        otp.attributedPlaceholder = NSAttributedString(string: "OTP", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#95989Aff")])
        //email.autocorrectionType = UITextAutocorrectionType.no
        otp.keyboardType = UIKeyboardType.default
        otp.returnKeyType = UIReturnKeyType.done
        otp.clearButtonMode = UITextFieldViewMode.whileEditing;
        otp.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        otp.tintColor = UIColor(hexString: "#20BFC6ff")
        otp.lineHeight = 1.0 // bottom line height in points
        otp.selectedLineHeight = 2.0
        otp.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        otp.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        otp.textColor = UIColor.white
        otp.title = "OTP"
        

        view.addSubview(otp)
        
        
        loginbtn.frame = CGRect(x: 20, y: 450 , width: screenWidth-40, height: 50)
        loginbtn.backgroundColor = UIColor(hexString: "#1C92AFff")
        loginbtn.layer.shadowColor = UIColor.black.cgColor
        loginbtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        loginbtn.layer.shadowRadius = 2
        loginbtn.layer.shadowOpacity = 1.0
        loginbtn.setTitle("Log ind", for: UIControlState.normal)
        loginbtn.tintColor = UIColor.black
        
        loginbtn.layer.cornerRadius = 6
        loginbtn.addTarget(self, action: #selector(loginfu),for: .touchUpInside)
        view.addSubview(loginbtn)
        
        
        
    }
    
    
    
    @objc private func loginfu(sender: Any){
        
        if self.otp.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")

            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID! ,
                verificationCode: otp.text!)
            // sign in user with credentials
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    print("error \(error.localizedDescription)")
                    return
                }
              
              print("logged into firebase")
                let user = Auth.auth().currentUser
                let uid = user?.uid
                print("uid: \(uid!)")
                customerDetails.sharedManager1.uid = uid!
                let fbRef = self.db.collection("Customers")
                let quer = fbRef.whereField("uid", isEqualTo: uid!)
                
                quer.getDocuments{(querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var count = 0;
                        
                        for document in querySnapshot!.documents {
                            count = count + 1
                        }
                        print("countless: \(count)")
                        if(count >= 1){
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                            self.present(vc!, animated: true, completion: nil)
                            print("Document exists)")
                        }else if(count == 0){
                            print("Document does not exist")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup")
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
                }
//                self.db.collection("Customers").document(uid!).getDocument{ (document, error) in
//                    if let document = document, document.exists {
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
//                        self.present(vc!, animated: true, completion: nil)
//                        print("Document exists)")
//                    } else {
//                        print("Document does not exist")
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signup")
//                        self.present(vc!, animated: true, completion: nil)
//                    }
//                }
                
            }
            
            
            
        }
        
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
