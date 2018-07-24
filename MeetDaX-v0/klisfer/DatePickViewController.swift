//
//  DatePickViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 07/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import DatePickerDialog
import JSSAlertView
import Alamofire
import JASON

class DatePickViewController: UIViewController  {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    let datePicker = UIDatePicker()
    var string1 = String()
    // @IBOutlet weak var myDatePicker: UIDatePicker!
    var date = String()
    var time = String()
    var allSlots = ["9:00" , "10:00" , "11:00" , "12:00" , "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"]
    var slotIndex = [String]()
    var blocked = [Int]()
    @IBOutlet weak var barberName: UILabel!
    
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var selectedDt: UITextField!
    @IBOutlet weak var slctdtime: UILabel!
    @IBOutlet weak var serv1: UILabel!
    @IBOutlet weak var serv2: UILabel!
    @IBOutlet weak var barberImage: UIImageView!
    @IBOutlet weak var booknowBtn: UIButton!
    @IBOutlet weak var datePickButton: UIButton!
    
    @IBOutlet weak var card: CardView!
    //slot button action
    @IBOutlet var slots: [UIButton]!
    
    @IBAction func slotAction(_ sender: UIButton) {
      
        print("clicked button is : \(sender.tag)")
     switch (sender.tag) {
        case 1:
            guard let button = sender as? UIButton else { return }
             self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 0   && !(blocked.contains(i))){
                   slot.isSelected = false
                   slot.backgroundColor = UIColor(hexString: "#ffffffff")
                   slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "9:00 AM"
                //button.setTitleColor(UIColor(hexString: "#ffffffff"), for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                button.setTitleColor(UIColor.white, for: .normal)

                slctdtime.text = ("kl. 9:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        
        case 2:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 1  && !(blocked.contains(i))){
                    
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                print("selected")
                self.time = "10:00 AM"
                //button.setTitleColor(UIColor(hexString: "#ffffffff"), for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                button.setTitleColor(UIColor.white, for: .normal)
                
                slctdtime.text = ("kl. 10:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                print("unselected")
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
        }
        

        case 3:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 2  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false){
                button.isSelected = true
                self.time = "11:00 AM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 11:00")
                setupDate()
            }
            else if (button.isSelected == true) {
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 4:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 3  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "12:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 12:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 5:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 4  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "1:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 13:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 6:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 5  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "2:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 14:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 7:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 6  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "3:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 15:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 8:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 7  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "4:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 16:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 9:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 8   && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "5:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 17:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 10:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 9  && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
                self.time = "6:00 PM"
                button.setTitleColor(UIColor.white, for: .normal)
                button.backgroundColor = UIColor(hexString: "#20BFC6ff")
                slctdtime.text = ("kl. 18:00")
                setupDate()
            }
            else if (button.isSelected == true){
                button.isSelected = false
                self.time = ""
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        
        default:
            guard let button = sender as? UIButton else { return }
        }
        
    }
    
    
    
    
//
//    @IBAction func slotAct1(_ sender: Any) {
//
//
//
//    }
//
//    @IBAction func slotAct2(_ sender: Any) {
//
//
//
//
//    }
//    @IBAction func slotAct3(_ sender: Any) {
//
//    }
//
//    @IBAction func slotAct4(_ sender: Any) {
//
//    }
//    @IBAction func slotAct5(_ sender: Any) {
//
//    }
//
//    @IBAction func slotAct6(_ sender: Any) {
//
//    }
//    @IBAction func slotAct7(_ sender: Any) {
//
//    }
//    @IBAction func slotAct8(_ sender: Any) {
//
//    }
//    @IBAction func slotAct9(_ sender: Any) {
//
//    }
//    @IBAction func slotAct10(_ sender: Any) {
//
//    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
       
       
      
      
//        let url = URL(string: self.delegate.stylist_pic_url)
//        barberImage.kf.setImage(with: url)
        if((dataToPost.sharedManager.services).count == 2){
            serv1.text =  dataToPost.sharedManager.servicesNames[0]
            serv2.text =  dataToPost.sharedManager.servicesNames[1]
        }else if((dataToPost.sharedManager.services).count == 1){
            serv1.text =  dataToPost.sharedManager.servicesNames[0]
            serv2.text = " "
        }else if((dataToPost.sharedManager.services).count == 0){
            serv1.text = " "
            serv2.text = " "
        }
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.barbernLabel.text = delegate.stylist
        //  self.barberImage.layer.cornerRadius = 6
        //  self.bookNowbtn.layer.cornerRadius = 6


        
        //print("delegate values \(delegate.selserv_Id)  => \(delegate.selserv_stylists)")
        let img = UIImage(named: "card-bg")
        card.backgroundColor = UIColor(patternImage: img!)
        setupLayout()
        createDatePicker()
        self.barberName.text = dataToPost.sharedManager.stylistName
        let url =  URL(string: dataToPost.sharedManager.imgUrl)
        
        self.barberImage.kf.setImage(with: url)
        // Do any additional setup after loading the view.
        
        
        
        for  slot in slots {
            
            slot.layer.shadowColor = UIColor.black.cgColor
            slot.layer.shadowOffset = CGSize(width: 1, height: 1)
            slot.layer.shadowRadius = 1
            slot.layer.shadowOpacity = 0.4
            slot.tintColor = .clear
            
            
            
        }
        
        datePickButton.layer.shadowColor = UIColor.black.cgColor
        datePickButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        datePickButton.layer.shadowRadius = 1
        datePickButton.layer.shadowOpacity = 0.4
        booknowBtn.applyGradients(colours: [UIColor(hexString: "#535353"), UIColor(hexString: "#383838")], locations: [0.5, 1.0])
       booknowBtn.layer.masksToBounds = true
        //slot1.frame  = CGRect(x:0,y:0, width: view.frame.width/2,height: 0)
        //booknowBtn.backgroundColor = UIColor(hexString: "#ffffffff")
        booknowBtn.layer.shadowColor = UIColor.black.cgColor
        booknowBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        booknowBtn.layer.shadowRadius = 1
        booknowBtn.layer.shadowOpacity = 0.4
        booknowBtn.layer.cornerRadius = 3
        // booknowBtn.addTarget(self, action: #selector(pickDate),for: .touchUpInside)
        booknowBtn.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
    }
    
    @objc func buttonAction(){
        var ref:DocumentReference? = nil
        var user = Auth.auth().currentUser;
        
        if let user = user{
            let mail = user.email
        }
        
        
        //let endDate = calendar.date(byAdding: .minute, value: duration, to: self.delegate.aptDate)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
        let string = self.date + " at " + self.time  // "March 24, 2017 at 7:00 AM" '20 February 2018 12:00'
      
        let finalDate = dateFormatter.date(from: string)!
        print("DateString \(finalDate )")
        dataToPost.sharedManager.startDate = finalDate
        let calendar = finalDate
        let Later = TimeInterval(dataToPost.sharedManager.duration.minutes)
        let endDate = calendar.addingTimeInterval(Later)
        dataToPost.sharedManager.endDate = endDate
        
        let dateFormatter3 = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: self.time)
        
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.string(from: date!)
        
        
        
        print("time: \(date24)")
        
        print("calendar \(calendar)")
        print("endDate \(endDate)")
       
      
        if (dataToPost.sharedManager.updateId == nil){

        let spin2 = UIViewController.displaySpinner(onView: self.view)
            ref = db.collection("bookings").addDocument(data: [
                "stylist" : dataToPost.sharedManager.stylistId,
                "customer" : user?.uid,
                "services" : dataToPost.sharedManager.services,
                "startDate": dataToPost.sharedManager.startDate,
                "imageUrl" : dataToPost.sharedManager.imgUrl,
                "duration" : dataToPost.sharedManager.duration,
                "endDate" : dataToPost.sharedManager.endDate,
                "price" : dataToPost.sharedManager.price,
                "eid" : "",
                "how_often" : "",
                "id" : ""
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
             UIViewController.removeSpinner(spinner: spin2)
        }else{
            let spin2 = UIViewController.displaySpinner(onView: self.view)
            db.collection("bookings").document(dataToPost.sharedManager.updateId!).updateData([
                "stylist" : dataToPost.sharedManager.stylistId,
                "customer" : user?.uid,
                "services" : dataToPost.sharedManager.services,
                "startDate": dataToPost.sharedManager.startDate,
                "imageUrl" : dataToPost.sharedManager.imgUrl,
                "duration" : dataToPost.sharedManager.duration,
                "endDate" : dataToPost.sharedManager.endDate,
                "price" : dataToPost.sharedManager.price,
                "eid" : "",
                "how_often" : "",
                "id" : ""
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")

                    func myCallback2() {
                        dataToPost.sharedManager.switchToEventFlag = true
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
                        dataToPost.sharedManager.switchToEventFlag = true
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
                    dataToPost.sharedManager.updateId = ""
                    dataToPost.sharedManager.updateIndex = nil
                    
                    print("Document successfully updated!")
                    print(self.delegate.update_id)
                }
            }
            UIViewController.removeSpinner(spinner: spin2)
        }
        
       
        
        
    }
    @objc func pickDate(){
        
        //        let toolbar = UIToolbar()
        //        toolbar.sizeToFit()
        //        datePicker.datePickerMode = .date
        //        //add a done button on this toolbar
        //        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        //
        //        toolbar.setItems([doneButton], animated: true)
        
        
    }
    
    func createDatePicker(){
        
        //assign datepicker to our textfield
        selectedDt.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()

        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        selectedDt.inputAccessoryView = toolbar
        
        
    }
    
    // combine date and time to convert into datetime
    private func setupDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
        
        //        (finalDate?.description(with: .current))
        //print(finalDate)
    }
    
    @objc func doneClicked(){
        
        selectedDt.text = " "
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        
        
        
        let dates = Date()
        let formatters = DateFormatter()
        formatters.dateFormat = "MMMM dd, yyyy"
        let result = formatters.string(from: dates)
        
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        datePickButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        datePickButton.setTitleColor(UIColor(hexString: "#ffffffff"), for: .normal)
        datePickButton.backgroundColor = UIColor(hexString: "#20BFC6ff")
        //selectedDt.text = dateFormatter.string(from: datePicker.date)
        self.date = dateFormatter.string(from: datePicker.date)
        //delegate.dateTime = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        selectedDate.text = ("- \(self.date)")
        let dateFormatter5 = DateFormatter()
        dateFormatter5.dateFormat = "MM"
        let month = dateFormatter5.string(from: datePicker.date)
        dateFormatter5.dateFormat = "dd"
        let day = dateFormatter5.string(from: datePicker.date)
        string1 = day + month
        print("document field: \(self.date)")
        
        // blocking current day past slots
        if(self.date == result){
            for (i,slot) in self.slots.enumerated(){
                let temp = (i + 9)
                if( temp <= hour){
                    slot.isEnabled = false
                    slot.backgroundColor = UIColor.lightGray
                    self.blocked.append(i)
                }
                
            }
        }
        
        
        print("Document data: \(self.delegate.slots)" )
        
        
        
        
        //free busy request
        
        let dateFormatters = DateFormatter()
        dateFormatters.locale = Locale(identifier: "en_US_POSIX")
        dateFormatters.dateFormat = "MMMM dd, yyyy HH:mm"
        let string: String? = self.date + " 00:00 AM"
        //let finalDatess = dateFormatters.date(from: string!)
        print("DateString1ofthe \(string )")

        let dateFormatter1 = DateFormatter()
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.dateFormat = "MMMM dd, yyyy  HH:mm "
        let string2 : String? = self.date +  " 11:00 PM"

        //let finalDate1 = dateFormatter1.date(from: string2!)
        print("DateString2ofthe \(string2 )")
        
        
        let startDate = string
        let endDate = string2
        //let currentStylistID = "is7LSMqHlyt0XQWpoJxw"
        let path = "https://us-central1-meetdax4.cloudfunctions.net/freeBusyFlow1"
        guard let url = URL(string: path) else { return }
        // cloud functions freebusy call
        let parameters :  [String : Any] = ["startDate" : string!, "endDate" : string2! , "currentStylistID" : dataToPost.sharedManager.stylistId ]
        print("parameters  \(parameters)")
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                
                let abc = JSON(response.data)
                let date = Date()
                let formatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, yyyy  HH:mm "
                let result = formatter.string(from: date)

                print("date: \(result)")
                for (i,slot) in self.slots.enumerated(){
                    let temp = String(i + 9)
                    if((abc[temp].int as! Int) == 0 ){
                        slot.isEnabled = false
                        slot.backgroundColor = UIColor.lightGray
                        self.blocked.append(i)
                    }
                    
                }
                
                
                
                debugPrint("getChatGroupConversationAvatars success")
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //timeout here
                    debugPrint("getChatGroupConversationAvatars timeOut")
                }
                debugPrint("getChatGroupConversationAvatars \(error)")
            }
        }
        
        
        
        
        
    }
    
    private func setupLayout(){
        // dayBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        // monthBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        //  yearBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        
        //monthBtn.frame = CGRect(x:view.frame.width/3 , y:0 , width : view.frame.width/3 , height: 40)
        
        
        //yearBtn.frame = CGRect(x:2*(view.frame.width/3) , y:0 , width : view.frame.width/3 , height: 40)
        
    }
    
    //    @IBAction func atePickerAction(_ sender: Any) {
    //
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    //        let strDate = dateFormatter.string(from: myDatePicker.date)
    //        self.selectedDate.text = strDate
    //        delegate.dateTime = strDate
    //        self.selectedTime.text = strDate
    //        print(delegate.dateTime)
    //    }
    
    //    @IBAction func submitButtonAction(_ sender: Any) {
    //        var ref:DocumentReference? = nil
    //        var user = Auth.auth().currentUser;
    //
    //        if let user = user{
    //            let mail = user.email
    //        }
    //
    //        if (self.delegate.update_id == nil){
    //        ref = db.collection("events").addDocument(data: [
    //            "stylist" : delegate.stylist,
    //            "customers" : user?.displayName,
    //            "services" : delegate.services,
    //            "startDate": delegate.aptDate,
    //            "email" : user?.email,
    //            "imgUrl" : delegate.stylist_pic_url
    //        ]){ err in
    //            if let err = err {
    //                print("Error adding document: \(err)")
    //            } else {
    //                print("Document added with ID: \(ref!.documentID)")
    //            }
    //        }
    //        }else{
    //             db.collection("events").document(self.delegate.update_id!).updateData([
    //                "stylist" : delegate.stylist,
    //                "services" : delegate.services,
    //                "startDate": delegate.aptDate
    //            ]) { err in
    //                if let err = err {
    //                    print("Error updating document: \(err)")
    //                } else {
    //                     self.delegate.update_id = nil
    //                    print("Document successfully updated!")
    //                    print(self.delegate.update_id)
    //                }
    //            }
    //        }
    //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
    //        self.present(vc!, animated: true, completion: nil)
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
extension Int {
    
    var seconds: Int {
        return self
    }
    
    var minutes: Int {
        return self.seconds * 60
    }
    
    var hours: Int {
        return self.minutes * 60
    }
    
    var days: Int {
        return self.hours * 24
    }
    
    var weeks: Int {
        return self.days * 7
    }
    
    var months: Int {
        return self.weeks * 4
    }
    
    var years: Int {
        return self.months * 12
    }
}



