//
//  functions.swift
//  klisfer
//
//  Created by aayush chaubey on 22/05/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

import UIKit
import JASON

class objects {
    
    // These are the properties you can store in your singleton
    var stylistData: [stylist] = []
    var stylistDataF2  : [stylist] = []
    var servicessMen: [services_common] = []
    var servicessWomen: [services_common] = []
    var servicessChildren: [services_common] = []
    var allServices: [services_common] = []
    var fetchedBookings: [bookings] = []
    //temp variables
    var servicesTemp : [services_common] = []
    
    class var sharedManager: objects {
        struct Static {
            static let instance = objects()
        }
        return Static.instance
    }

}


extension UIViewController{
    func fetchingData3(){
        var sty = [stylist]()
        //let spin3 = UIViewController.displaySpinner(onView: self.view)
        let db = Firestore.firestore()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        // fetch details for Choose barber controller
        
        db.collection("stylist").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                
                
                
                for document in querySnapshot!.documents {
                    
                    let fname = document.data()["firstName"] as! String
                    let lname = document.data()["lastName"] as! String
                    let funame = fname + " " + lname
                    let uid = document.documentID as! String
                    let imgUrl = document.data()["imageUrl"] as! String
                    let arr = document.data()["services"] as? NSArray
                    var objCArray = NSMutableArray(array: arr!)
                    // reading array from document
                    let swiftArray = (objCArray as NSArray as? [String])!
                    
                    
                    sty.append(stylist(id: uid , imageUrl: imgUrl ,name: funame ,  services: swiftArray))
                }
                //UIViewController.removeSpinner(spinner: spin3)
                
                objects.sharedManager.stylistData = sty
            }
            
        }
        
        
        
    }
    
    
    func fetchingData(completion: @escaping (Bool) -> Void) {
        //let spin1 = UIViewController.displaySpinner(onView: self.view)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let user = Auth.auth().currentUser
        let mail = user?.email
        var cust_id = String()
        
        let db = Firestore.firestore()
        
        
        db.collection("Customers").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let dataDescription = document.data()
                        customerDetails.sharedManager1.firstName = dataDescription["firstName"] as! String
                        customerDetails.sharedManager1.lastName = dataDescription["lastName"] as! String
                        customerDetails.sharedManager1.mobileNumber = dataDescription["phone"] as! String
                        customerDetails.sharedManager1.gender = dataDescription["gender"] as! String
                        customerDetails.sharedManager1.age = dataDescription["dob"] as! Date
                        customerDetails.sharedManager1.imgUrl = dataDescription["imageUrl"] as! String
                        customerDetails.sharedManager1.docID = document.documentID as! String
                        
                    }
                }
        }
            
        
        
            
        
        
        
        var servicesMen = [services_common]()
        var servicesWomen = [services_common]()
        var servicesChildren = [services_common]()
        
        
        db.collection("services_men").getDocuments(){ (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let json = JSON(document.data())
                    let id = document.documentID as! String
                    let price = document.data()["price"] as! Int
                    let name = document.data()["name"] as! String
                    let arr =  json["services"].array
                    
                    var swiftArray = [[String]]()
                    
                    var i = 0
                    while i < (arr?.count)!{
                        
                        var Array  = [String]()
                        let dur = json["services"][i]["duration"].string
                        let sty = json["services"][i]["stylist"].string
                        Array.append(dur!)
                        Array.append(sty!)
                        print(Array)
                        
                        swiftArray.append(Array)
                        i = i + 1
                    }
                    
                    servicesMen.append(services_common(id: id , name: name , price: price , services: swiftArray))
                  
                }
                  print("encaps \(servicesMen)")
                objects.sharedManager.servicessMen = servicesMen
                objects.sharedManager.allServices = servicesMen
                print("encaps \(objects.sharedManager.servicessMen)")
                print("Alltheservices : \(objects.sharedManager.allServices)")
            }
        }
        
        
        db.collection("services_women").getDocuments(){ (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let json = JSON(document.data())
                    let id = document.documentID as! String
                    let price = document.data()["price"] as! Int
                    let name = document.data()["name"] as! String
                    let arr =  json["services"].array
                    let dur = json["services"][0]["duration"].string
                    let sty = json["services"][0]["stylist"].string
                    var swiftArray = [[String]]()
                    var i = 0
                    while i < (arr?.count)!{
                        
                        var Array  = [String]()
                        let dur = json["services"][i]["duration"].string
                        let sty = json["services"][i]["stylist"].string
                        Array.append(dur!)
                        Array.append(sty!)
                        
                        
                        swiftArray.append(Array)
                        i = i + 1
                    }
                    
                    servicesWomen.append(services_common(id: id , name: name , price: price , services: swiftArray))
                    
                }
                
                objects.sharedManager.servicessWomen = servicesWomen
                objects.sharedManager.allServices  = objects.sharedManager.allServices + servicesWomen
                print("Alltheservices : \(objects.sharedManager.allServices)")
            }
        }
        
        
        
        db.collection("services_children").getDocuments(){ (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let json = JSON(document.data())
                    let id = document.documentID 
                    let price = document.data()["price"] as! Int
                    let name = document.data()["name"] as! String
                    let arr =  json["services"].array
                    
                    var swiftArray = [[String]]()
                    var i = 0
                    while i < (arr?.count)!{
                        
                        var Array  = [String]()
                        let dur = json["services"][i]["duration"].string
                        let sty = json["services"][i]["stylist"].string
                        Array.append(dur!)
                        Array.append(sty!)
                        
                        
                        swiftArray.append(Array)
                        i = i + 1
                    }
                    
                    servicesChildren.append(services_common(id: id , name: name , price: price , services: swiftArray))
                    
                }
                
                objects.sharedManager.servicessChildren = servicesChildren
                objects.sharedManager.allServices  = objects.sharedManager.allServices + servicesChildren
                print("Alltheservices : \(objects.sharedManager.allServices)")
                completion(true)
            }
        }
        
        
    }
    
    
    
    
    
    func fetchingData2(completion: @escaping (Bool) -> Void) {
        var fetcheddata = bookings()
        objects.sharedManager.fetchedBookings.removeAll()
        objects.sharedManager.allServices = (objects.sharedManager.servicessMen) + (objects.sharedManager.servicessWomen) + (objects.sharedManager.servicessChildren)
        print("obj  \(objects.sharedManager.servicessMen)" )
        print("servm \(objects.sharedManager.servicessWomen)")
        print("servw \(objects.sharedManager.servicessChildren)")
        print("servc \(objects.sharedManager.allServices)")
        
        let spin2 = UIViewController.displaySpinner(onView: self.view)
        var formatter = DateFormatter()
        var aptDate = String()
        var startTime = String()
        var endTime = String()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
      
        
        let userID = Auth.auth().currentUser!.uid
        
        let db = Firestore.firestore()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        db.collection("bookings").whereField("customer", isEqualTo: Auth.auth().currentUser?.uid).getDocuments{ (snapshot, error) in
            
            if error != nil{
                print(error)
            }else{
                
                for document in (snapshot!.documents){
                    

                    let doc_id =  document.documentID as! String
                    fetcheddata.docId = doc_id
                    
                    
                    let stylist_id = document.data()["stylist"] as? String
                    fetcheddata.stylistId = stylist_id!
                    //fetching img url of event stylist
                  
                    let img_url = document.data()["imageUrl"] as? String
                    
                    fetcheddata.imgUrl = img_url!
                    
                 
                    
                    
                    var barberName : String? = ""
                    
                    for i in objects.sharedManager.stylistData{
                        if(i.id == stylist_id ){
                            barberName = i.name
                        }
                    }
                    fetcheddata.stylistName = barberName!
                 
                    
                    
                    // fetching services array and storing in delegate(global var)
                    let arr = document.data()["services"] as? NSArray
                    let objCArray = NSMutableArray(array: arr!)
                    // reading array from document
                    let swiftArray = (objCArray as NSArray as? [String])!
                    fetcheddata.services = swiftArray
                    
                    var arr1 = [String]()
                    print("Allservices : \(objects.sharedManager.allServices)")
                    for i in swiftArray{
                        for j in objects.sharedManager.allServices{
                            if(i == j.id){
                                print("i \(i) , j: \(j.id)")
                                arr1.append(j.name)
                            }
                            
                        }
                    }
                    
                    fetcheddata.servicesNames = arr1
                    print("servicesNames \(arr1)")
                    print("servicesNames \(fetcheddata.servicesNames)")
                    
                    // adding startDate
                    aptDate =  document.data()["date"] as! String
                    startTime = document.data()["startTime"] as! String
                    endTime = document.data()["endTime"] as! String
                 
                    fetcheddata.date = aptDate
                    fetcheddata.startTime = startTime
                    fetcheddata.endTime = endTime
                 
                    
                    objects.sharedManager.fetchedBookings.append(fetcheddata)
                }
                completion(true)
                UIViewController.removeSpinner(spinner: spin2)
                print("fetched data is: \(objects.sharedManager.fetchedBookings)")
            }
        }
        
    }
    
    
    
}
