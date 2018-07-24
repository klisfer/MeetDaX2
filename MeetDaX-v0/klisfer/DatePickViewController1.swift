//
//  DatePickViewController1.swift
//  klisfer
//
//  Created by aayush chaubey on 24/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import DatePickerDialog
import JSSAlertView
import Alamofire
import JASON

class DatePickViewController1: UIViewController {
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
                if(i != 0 && !(blocked.contains(i))){
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
                if(i != 1 && !(blocked.contains(i))){
                    slot.isSelected = false
                    slot.backgroundColor = UIColor(hexString: "#ffffffff")
                    slot.setTitleColor(UIColor.darkGray, for: .normal)
                    
                }
            }
            if (button.isSelected == false) {
                button.isSelected = true
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
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
            
        case 3:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 2 && !(blocked.contains(i))){
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
                if(i != 3 && !(blocked.contains(i))){
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
                if(i != 4 && !(blocked.contains(i))){
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
                button.titleLabel?.textColor = UIColor.white
                button.backgroundColor = UIColor(hexString: "#ffffffff")
                slctdtime.text = ("")
            }
        case 6:
            guard let button = sender as? UIButton else { return }
            self.time = ""
            slctdtime.text = ("")
            for  (i,slot) in slots.enumerated() {
                if(i != 5 && !(blocked.contains(i))){
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
                if(i != 6 && !(blocked.contains(i))){
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
                if(i != 7 && !(blocked.contains(i))){
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
                if(i != 8 && !(blocked.contains(i))){
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
                if(i != 9 && !(blocked.contains(i))){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.barbernLabel.text = delegate.stylist
        //  self.barberImage.layer.cornerRadius = 6
        //  self.bookNowbtn.layer.cornerRadius = 6
       print("cahl be \(dataToPost.sharedManager.servicesNames)")
        
        if(dataToPost.sharedManager.services.count == 1){
            self.serv1.text = dataToPost.sharedManager.servicesNames[0]
        }else if(dataToPost.sharedManager.services.count == 2){
            
            self.serv1.text = dataToPost.sharedManager.servicesNames[0]
            self.serv2.text = dataToPost.sharedManager.servicesNames[1]
            
        }
        
        //print("delegate values \(delegate.selserv_Id)  => \(delegate.selserv_stylists)")
        let img = UIImage(named: "card-bg")
        card.backgroundColor = UIColor(patternImage: img!)
        setupLayout()
        createDatePicker()
        
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
        datePickButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        datePickButton.layer.shadowRadius = 3
        datePickButton.layer.shadowOpacity = 0.4
        
        
        //slot1.frame  = CGRect(x:0,y:0, width: view.frame.width/2,height: 0)
        //booknowBtn.backgroundColor = UIColor(hexString: "#ffffffff")
        booknowBtn.layer.shadowColor = UIColor.black.cgColor
        booknowBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        booknowBtn.layer.shadowRadius = 6
        booknowBtn.layer.shadowOpacity = 0.4
        booknowBtn.layer.cornerRadius = 6
        // booknowBtn.addTarget(self, action: #selector(pickDate),for: .touchUpInside)
        booknowBtn.addTarget(self, action: #selector(buttonAction),for: .touchUpInside)
        booknowBtn.applyGradients(colours: [UIColor(hexString: "#535353"), UIColor(hexString: "#383838")], locations: [0.5, 1.0])
        booknowBtn.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonAction(){
        var ref:DocumentReference? = nil
        var user = Auth.auth().currentUser;
        let spin2 = UIViewController.displaySpinner(onView: self.view)
        if let user = user{
            let mail = user.email
        }
        
        
        //let endDate = calendar.date(byAdding: .minute, value: duration, to: self.delegate.aptDate)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
       
        
        
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter2.dateFormat = "h:mm a"
        let date = dateFormatter2.date(from: self.time)
        
        let shift : Int = -330  //subtracting 5 hrs and 30 mins to adjust 
        let timezone = TimeInterval(shift.minutes)
        let date1 = date?.addingTimeInterval(timezone)
        let tempString1 = dateFormatter2.string(from: date1!)
        let string = self.date + " " + tempString1  // "March 24, 2017 7:00 AM" '20 February 2018 12:00'
        let string11 = self.date + " at " + self.time  // "March 24, 2017 at 7:00 AM" '20 February 2018 12:00'
        //let finalDate = dateFormatter.date(from: string)!
        let startDate = dateFormatter.date(from: string11)!
        print("DateString \(startDate )")
        dataToPost.sharedManager.startDate = startDate
        let dur : Int = -270
        let Later = TimeInterval(dur.minutes)
        
        
        let dateFormatter3 = DateFormatter()
         dateFormatter3.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter3.dateFormat = "h:mm a"
        
        let date2 = date?.addingTimeInterval(Later)
        let tempString = dateFormatter3.string(from: date2!)
        let string2 = self.date + " " + tempString
        
        
        
        
        
        
        //free busy request
        

        let path = "https://us-central1-meetdax4.cloudfunctions.net/freeBusyFlow2"
        guard let url = URL(string: path) else { return }
        var stylists = [String]()
        var freeBusy = [Int]()
        for i in objects.sharedManager.stylistDataF2{
            stylists.append(i.id)
        }
        print("delegate.selserv  \(stylists) startDAte: \(string)  enddate \(string2)")
       
        for i in stylists{
        
        let parameters :  [String : Any] = ["startDate" : string, "endDate" : string2 , "currentStylistID" : i ]
        print("parameters  \(parameters)")
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                
                print("the resonse is \(response)")
                print("the resonse is \(response.data)")
                let abc = JSON(response.data)
                if let result = response.result.value {
                    let JSON = result as! Int

                    
                    if(JSON == 0 ){
                        freeBusy.append(0)
                        for (j,doc) in objects.sharedManager.stylistDataF2.enumerated(){
                            if(doc.id == i){
                                objects.sharedManager.stylistDataF2.remove(at: j)
                            }
                        }
                        
                    }else if (JSON == 1){
                        freeBusy.append(1)
                    }
                    
                    print("free or not: \(freeBusy) ")
                }
                
                
                debugPrint("getChatGroupConversationAvatars success")
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
                    //timeout here
                    debugPrint("getChatGroupConversationAvatars timeOut")
                }
                debugPrint("getChatGroupConversationAvatars \(error)")
            }
            } .responseJSON{ result in
                print("the result is \(result)")
            }
        
     }
      
        
        
//        for (i, id) in stylists.enumerated(){
//            if(freeBusy[i] == 0){
//             for (j,doc) in objects.sharedManager.stylistDataF2.enumerated(){
//                if(doc.id == id){
//                    objects.sharedManager.stylistDataF2.remove(at: j)
//                }
//             }
//           }
//        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // change 2 to desired number of seconds
            UIViewController.removeSpinner(spinner: spin2)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "barberSelect1")
//            self.present(vc!, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc!, animated:
                true)
        }
        
       
        
        
        
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
        //current date
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        // current time and hour
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
        
        
        
        // blocking current date slots before current time
    
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
        
 
        
    }
    
    private func setupLayout(){
        // dayBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        // monthBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        //  yearBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        
        //monthBtn.frame = CGRect(x:view.frame.width/3 , y:0 , width : view.frame.width/3 , height: 40)
        
        
        //yearBtn.frame = CGRect(x:2*(view.frame.width/3) , y:0 , width : view.frame.width/3 , height: 40)
        
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
