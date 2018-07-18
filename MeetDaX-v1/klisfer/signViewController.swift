//
//  signViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 05/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SkyFloatingLabelTextField
import JASON

class signViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource ,UITextFieldDelegate{
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
    let datePicker = UIDatePicker()
    var dates = String()
    var email = SkyFloatingLabelTextField()
    var password = SkyFloatingLabelTextField()
    var fullname = SkyFloatingLabelTextField()
    var mobile = SkyFloatingLabelTextField()
    var genderSelect = SkyFloatingLabelTextField()
    var gender = SkyFloatingLabelTextField()
    var age = SkyFloatingLabelTextField()
    var terms = UILabel()
    var SignUpPage = UILabel()
    let confirmpassword = SkyFloatingLabelTextField()
    let db = Firestore.firestore()
    var servc : [String] = []
    let picker = UIPickerView()
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //@IBOutlet weak var email: SkyFloatingLabelTextField!
    //
    //    @IBOutlet weak var password: SkyFloatingLabelTextField!
    //
    //    @IBOutlet weak var fullname: SkyFloatingLabelTextField!
    //
    //    @IBOutlet weak var mobile: SkyFloatingLabelTextField!
    //
    @IBOutlet weak var agree: UITextView!
    //    @IBOutlet weak var gender: SkyFloatingLabelTextField!
    //
    //    @IBOutlet weak var age: SkyFloatingLabelTextField!
    //    @IBOutlet weak var confirmpassword: SkyFloatingLabelTextField!
    @IBOutlet weak var viewScroll: UIView!
    //
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var myImage: UIImageView!
    //     @IBOutlet weak var genderSelect: UITextField!
    var genders = ["Male", "Female", "Others"]
    @IBAction func importImage(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source" , message: "choose a source" , preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera" , style: .default , handler: {(action: UIAlertAction) in image.sourceType = .camera
            self.present(image , animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library" , style: .default , handler: {(action: UIAlertAction) in image.sourceType = .photoLibrary
            self.present(image , animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel" , style: .cancel , handler: nil ))
        
        self.present(actionSheet , animated: true , completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nav = self.navigationController?.navigationBar
        
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        setupLayout()
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Frontent - Layout setup
    
    func createDatePicker(){
        
        //assign datepicker to our textfield
        age.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        age.inputAccessoryView = toolbar
        
        
    }
    @objc func doneClicked(){
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        self.dates = dateFormatter.string(from: datePicker.date)
        //delegate.dateTime = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
         
        
        
        age.text = ("\(self.dates)")
    }
    
    
    
    
    private func setupLayout(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        //view
        
        self.viewScroll.backgroundColor = UIColor.clear
        
        //Label
        //descriptionTextView.frame = CGRect(x: 20, y: 100, width: screenWidth-40, height: 40)
        
        descriptionTextView.text = "Opret bruger"
        //descriptionTextView.font = UIFont(ofSize: 24)
        descriptionTextView.font = UIFont(name: "Helvetica", size: 24)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.textAlignment = .center
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.textColor = UIColor(hexString: "#008F95ff")
        
        
        descriptionTextView.backgroundColor = UIColor.clear
        viewScroll.addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: viewScroll.topAnchor, constant: 150).isActive = true
        descriptionTextView.centerXAnchor.constraint(equalTo: viewScroll.centerXAnchor).isActive = true
        
        
        //text Field email
        myImage.frame =  CGRect(x: (screenWidth - 0.15*screenHeight)/2, y: 200, width: 0.15*screenHeight , height: 0.15*screenHeight)
        myImage.contentMode = .scaleToFill
        
        uploadBtn.frame =  CGRect(x: (screenWidth - 0.15*screenHeight)/2 , y: 200 + 0.15*screenHeight , width: 0.15*screenHeight , height: 40)
        uploadBtn.layer.shadowColor = UIColor.black.cgColor
        uploadBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        uploadBtn.layer.shadowRadius = 2
        uploadBtn.layer.shadowOpacity = 0.5
        uploadBtn.layer.cornerRadius = 2
        uploadBtn.backgroundColor = UIColor(hexString: "#20BFC6ff")
        viewScroll.addSubview(uploadBtn)

        
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
        fullname.attributedPlaceholder = NSAttributedString(string: "Fornavn", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        //text Field Mobile
        fullname.tintColor = UIColor(hexString: "#20BFC6ff")
        fullname.lineHeight = 1.0 // bottom line height in points
        fullname.selectedLineHeight = 2.0
        fullname.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        fullname.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        fullname.textColor = UIColor(hexString: "#000000ff")!
        fullname.title = "Fornavn"
        
        
        
        
        mobile.frame = CGRect(x: 20, y: 390, width: screenWidth-40, height: 40)
        //mobile.placeholder = "Mobile Number"
        mobile.font = UIFont.systemFont(ofSize: 15)
        //mobile.borderStyle = UITextBorderStyle.roundedRect
        mobile.autocorrectionType = UITextAutocorrectionType.no
        mobile.keyboardType = UIKeyboardType.default
        mobile.returnKeyType = UIReturnKeyType.done
        mobile.clearButtonMode = UITextFieldViewMode.whileEditing;
        mobile.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        viewScroll.addSubview(mobile)
        // mobile.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        mobile.attributedPlaceholder = NSAttributedString(string: customerDetails.sharedManager1.mobileNumber, attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        mobile.tintColor = UIColor(hexString: "#20BFC6ff")
        mobile.lineHeight = 1.0 // bottom line height in points
        mobile.selectedLineHeight = 2.0
        mobile.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        mobile.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        mobile.textColor = UIColor(hexString: "#000000ff")!
        mobile.isEnabled = false
        mobile.title = "Mobile Number"
        
        
        //text Field gender
        
        gender.frame = CGRect(x: 20, y: 510, width: screenWidth-40, height: 40)
        //gender.placeholder = "Last Name"
        gender.font = UIFont.systemFont(ofSize: 15)
        // gender.borderStyle = UITextBorderStyle.roundedRect
        gender.autocorrectionType = UITextAutocorrectionType.no
        gender.keyboardType = UIKeyboardType.default
        gender.returnKeyType = UIReturnKeyType.done
        gender.clearButtonMode = UITextFieldViewMode.whileEditing;
        gender.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        viewScroll.addSubview(gender)
        //  gender.backgroundColor = UIColor(red: 0, green:0,  blue:0 ,alpha: 0.4)
        gender.attributedPlaceholder = NSAttributedString(string: "Efternavn", attributes: [NSAttributedStringKey.foregroundColor:  UIColor(hexString: "#95989Aff")])
        gender.tintColor = UIColor(hexString: "#20BFC6ff")
        gender.lineHeight = 1.0 // bottom line height in points
        gender.selectedLineHeight = 2.0
        gender.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        gender.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        gender.textColor = UIColor(hexString: "#000000ff")!
        gender.title = "Efternavn"
        
        
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
        age.title = "Dob"
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
        genderSelect.attributedPlaceholder = NSAttributedString(string: "Køn", attributes: [NSAttributedStringKey.foregroundColor: UIColor(hexString: "#95989Aff")])
        genderSelect.tintColor = UIColor(hexString: "#20BFC6ff")
        genderSelect.lineHeight = 1.0 // bottom line height in points
        genderSelect.selectedLineHeight = 2.0
        genderSelect.selectedTitleColor = UIColor(hexString: "#20BFC6ff")!
        genderSelect.selectedLineColor = UIColor(hexString: "#20BFC6ff")!
        genderSelect.textColor = UIColor(hexString: "#000000ff")!
        genderSelect.title = "Køn"
        genderSelect.layer.masksToBounds = true
        
        
        terms.frame = CGRect(x: 20, y: 690, width: screenWidth-40, height: 40)
        terms.text = "Ved at oprette en konto hos os, accepterer du samtidig vores Vilkår og Betingelser."
        terms.textColor = UIColor.black
        terms.font = UIFont.systemFont(ofSize: 12)
        terms.backgroundColor = UIColor.clear
        terms.textAlignment = .left
        terms.numberOfLines = 0
        
        viewScroll.addSubview(terms)
        //checkbox
        //        let checkbox = Checkbox(frame: CGRect(x: 30, y: 780, width: 25, height: 25))
        //        checkbox.borderStyle = .square
        //        checkbox.checkmarkColor = .blue
        //        checkbox.checkmarkStyle = .circle
        //        checkbox.borderStyle = .circle
        //        viewScroll.addSubview(checkbox)
        
        
        //agree terms
        
        //agree.frame = CGRect(x: 65, y: 740, width: screenWidth-85, height: 60)
        agree.text = "Jeg accepterer at modtage nyheder, eksklusive tilbud og mere fra barbershops. Du kan afmelde dig når som helst"
        agree.font = UIFont.systemFont(ofSize: 12)
        agree.translatesAutoresizingMaskIntoConstraints = false
        agree.textAlignment = .center
        agree.isEditable = false
        agree.isScrollEnabled = false
        agree.textColor = .black
        agree.backgroundColor = UIColor.clear
        agree.textAlignment = .left
        viewScroll.addSubview(agree)
        
        
        //button for SignUp
        let signupbutton = UIButton(frame: CGRect(x: 20, y: 845 , width: screenWidth - 40 , height: 50))
        signupbutton.setTitle("Log ind", for: UIControlState.normal)
        signupbutton.tintColor = UIColor.black
        signupbutton.backgroundColor = UIColor(hexString: "#20BFC6ff")
        signupbutton.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
        signupbutton.layer.shadowColor = UIColor.black.cgColor
        signupbutton.layer.shadowOffset = CGSize(width: 5, height: 5)
        signupbutton.layer.shadowRadius = 6
        signupbutton.layer.shadowOpacity = 0.4
        signupbutton.layer.cornerRadius = 6
        viewScroll.addSubview(signupbutton)
        
        
        SignUpPage.frame = CGRect(x: 20, y: 905, width: screenWidth-40, height: 40)
        SignUpPage.text = "Don't have an account? Sign Up"
        SignUpPage.textColor = UIColor.black
        SignUpPage.font = UIFont.systemFont(ofSize: 12)
        SignUpPage.backgroundColor = UIColor.clear
        SignUpPage.textAlignment = .center
        SignUpPage.numberOfLines = 0
        
        viewScroll.addSubview(SignUpPage)
        
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @objc func buttonAction(sender: UIButton!) {
        fetchingData(completion : {  success in
            
        })
        fetchingData3()
        //authenticate email signup users.
        if gender.text == "" || fullname.text == "" || genderSelect.text == "" || age.text == ""  {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "fejl", message: "alle felter skal udfyldes", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            
               uploadMedia(){ url in
                 let spin2 = UIViewController.displaySpinner(onView: self.view)
                
                
           
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
                let string = self.age.text! + " 00:00 AM"
                let finalDate = dateFormatter.date(from: string)!
                //Print into the console if successfully logged in
                let uid = customerDetails.sharedManager1.uid
                //write to db
              var ref: DocumentReference? = nil
              ref = self.db.collection("Customers").addDocument(data: [
                    "firstName": self.fullname.text!,
                    "lastName": self.gender.text!,
                    "phone" : customerDetails.sharedManager1.mobileNumber,
                    "dob" : finalDate,
                    "gender": self.genderSelect.text!,
                    "uid" : uid,
                    "imageUrl" : url!
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                
                // print("URLsss is: \(urls!)")
                
               
                customerDetails.sharedManager1.firstName = self.fullname.text!
                customerDetails.sharedManager1.lastName = self.gender.text!
                
                customerDetails.sharedManager1.gender = self.genderSelect.text!
                customerDetails.sharedManager1.age = finalDate
                customerDetails.sharedManager1.imgUrl = url!
                customerDetails.sharedManager1.docID = ref!.documentID
                
                UIViewController.removeSpinner(spinner: spin2)
                // Go to the HomeViewController if the login is sucessful
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                self.present(vc!, animated: true, completion: nil)
                
                
                
            }
            
            
        }
    }
    
    
    func uploadMedia(completion: @escaping (_ completion: String?) -> Void) {
        print("current user for image upload: \((Auth.auth().currentUser?.uid)!)")
        
        
        
        let storageRef = Storage.storage().reference().child("customers/\((Auth.auth().currentUser?.uid)!).png")
        if let uploadData = UIImagePNGRepresentation(self.myImage.image!) {
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
                 print("the url is \(url)")
                var urlString: String = url!.absoluteString
                  completion(urlString)
                }
            }
        }
        
    }
    
    
    
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}



