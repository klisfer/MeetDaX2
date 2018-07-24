//
//  AppDelegate.swift
//  klisfer
//
//  Created by aayush chaubey on 28/02/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn
import FirebaseFirestore
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    
    var window: UIWindow?
    // stylist name to post
    var stylist = String()
    //stylist id to post
    var stylist_id = String()
    //stylist pic url  to post
    var stylist_pic_url = String()
    //row no. seleted in choose stylist
    var row_no = Int()
    // customer name
    var customer = String()
    //customer id to post
    var customer_id = String()
    //services selected by user
    var services : [String] = []
    // fb/googlefetched profile image
    var profile_image = UIImage()
    //id of services selected by user
    var servicesId : [String] = []
    //string of date
    var dateTime = String()
    //apointment date
    var aptDate = Date()
    //booked services individual prices
    var servPrice: [Int] = []
    //booked services individual durations
    var servDuration : [Int] = []
    //services provided by that particular stylist
    var servProv : [String] = []
    //id of services provided by that particular stylist
    var servProvId : [String] = []
    //selected stylist pic
    var stylistPic = [String: UIImage]()
    // customer pic
    var customerPic = [String: UIImage]()
    
    
    
    
    //AVAILABLE SLOTS DATA
    var slots : [String?] = []
    
    // all th barber names for updating in the tableview
    var barberName = [String]()
    // doc id of all barbers
    var uid_stylists = [String]()
    var barberPicUrl = [String]()
    var allBarberPic: [UIImage] = []
    var  barberServices : [[String]] = [[]]
    var   serviceFor = [String]()
    var all_barbers = [String:String]()
    
    
    //booked events fetch global variables
    var event_service : [[String?]] = [[]]
    var event_service_name : [[String?]] = [[]]
    var event_dateTime : [Date] = []
    var doc_id : [String] = []
    var  update_id : String?
    var event_stylists_pic_url : [String] = []
    var event_stylists_name : [String] = []
    var event_stylists_id : [String] = []
    var event_timestamp : [Date] = []
    
    
    //fetching all the services
    var all_services = [String:String]()
    var alltheserviceNames = [String:String]()
    var all_services_prices = [Int]()
    
    
    //fetching all the products
    var prod_name : [String] = []
    var prod_desc : [String] = []
    var prod_img_url : [String] = []
    var prod_price : [String] = []
    
    
    //fetching all the promotions
    var prom_name : [String] = []
    var prom_img_url : [String] = []
    var prom_serv1 : [String] = []
    var prom_serv2 : [String] = []
    var prom_serv3 : [String] = []
    var prom_price : [String] = []
    
    
    //customer details
    
    var cust_name = String()
    var cust_mail = String()
    var cust_phone = String()
    var cust_age = String()
    var cust_gender = String()
    var cust_image = [String: UIImage]()
    
    
    //selected services available stylists
    var selserv_stylists : [String] = []
    var selserv_stylists_name : [String] = []
    var selserv_stylists_serviceFor : [String] = []
    var selserv_stylists_imgurl : [String] = []
    //selected serviceNames , service collection id
    var selserv_Id : [String] = []
    //selected services stylists id
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        FirebaseApp.configure()
        
        
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        return true
    }
    
    func run(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateTime)!
        self.aptDate = date
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,annotation: [:])
        
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,annotation:options[UIApplicationOpenURLOptionsKey.annotation] )
        
        return true
    }
    
    
    
    
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

