//
//  EventsViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 15/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Kingfisher
import FirebaseAuth
import FirebaseFirestore
import AnimatableReload


class EventsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let barbers = ["Dorothe Sorensen", "Wasim Mohammed" , "Julia Ruser", "Dorianne R"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
      
        return (objects.sharedManager.fetchedBookings.count)
    }
    
    @IBOutlet weak var tableEvents: UITableView!
    
    
    
    let db = Firestore.firestore()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventsTableViewCell
         cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.barberName.text = objects.sharedManager.fetchedBookings[indexPath.row].stylistName
        //cell.barberPic.image = UIImage(named: (barbers[indexPath.row]   + ".png"))
        
        if((objects.sharedManager.fetchedBookings[(indexPath.row)].services.count) >= 2){
            cell.serv1!.text = objects.sharedManager.fetchedBookings[indexPath.row].servicesNames[0]
            //print ("1st: \(self.delegate.event_service_name[indexPath.row][0]) " )
            
            
            
            cell.serv2!.text = objects.sharedManager.fetchedBookings[indexPath.row].servicesNames[1]
            //print ("2nd: \(self.delegate.event_service_name[indexPath.row][0]) " )
            
        }else if((objects.sharedManager.fetchedBookings[indexPath.row].services.count) == 1){
            cell.serv1!.text = objects.sharedManager.fetchedBookings[indexPath.row].servicesNames[0]
            //print ("1st: \(self.delegate.event_service_name[indexPath.row][0]) " )
            
            
            cell.serv2?.text = " "
            print ("1st: \(indexPath.row) " )
            
        }else {
           
            
        }
       
        //cell.dateTime.text = self.delegate.event_dateTime[indexPath.row]
        let event_date = objects.sharedManager.fetchedBookings[indexPath.row].date
        
        
        // display formatting fetched date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        var dateToPost : String?
        
        var dates = dateFormatterGet.date(from: event_date)
        if let date = dateFormatterGet.date(from: event_date){
            dateToPost = dateFormatterPrint.string(from: date)
        }
        else {
            print("There was an error decoding the string")
        }
        
//        let finalDate = dateFormatter.date(from: event_date)!
//        let date = dateFormatter.string(from: finalDate)
        
        //display formatting time
        let event_time = objects.sharedManager.fetchedBookings[indexPath.row].startTime
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "HH:mm"
        let event_timeformat = dateFormatter3.date(from: event_time)!
        
        
        //dateFormatter.dateStyle = .medium
        
        
       // dateFormatter.locale = Locale(identifier: "en_US")
       
        
        //print("the time is: \(time)")
        cell.dateTime.text = event_time
        cell.dat.text = ("- \(dateToPost!)")
        cell.updateBtn.addTarget(self, action: #selector(updateEvent), for: .touchUpInside)
        cell.updateBtn.tag = indexPath.row
        //loading event stylist image
        
        
        
        let imgUrl = objects.sharedManager.fetchedBookings[indexPath.row].imgUrl
        let url = URL(string: imgUrl)
        cell.barberPic.kf.setImage(with: url)
        

        let date1 = Date()

        if date1 <= dates!  {
            let img = UIImage(named: "card-bg")
            cell.card.backgroundColor = UIColor(patternImage: img!)

        }else{
            cell.card.backgroundColor = UIColor.gray
        }
        
        
        return (cell)
    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let uid = objects.sharedManager.fetchedBookings[indexPath.row].docId
        objects.sharedManager.fetchedBookings.remove(at: (indexPath.row))
//        dataToPost.sharedManager.duration.remove(at: (indexPath.row))
//        dataToPost.sharedManager.endDate.remove(at: (indexPath.row))
//        self.delegate.event_stylists_pic_url.remove(at: (indexPath.row))
//        let uid = self.delegate.doc_id[indexPath.row]
//        self.delegate.doc_id.remove(at: (indexPath.row))
//        self.delegate.event_dateTime.remove(at: indexPath.row)
//
        
        //delete firestore document
        db.collection("bookings").document(uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        tableView.reloadData()
        AnimatableReload.reload(tableView: tableView, animationDirection: "up")
        
        

    }
    
    
    
    
    //event update
    @objc private func updateEvent(sender: UIButton){
        let btnTag = sender.tag
        
        let uid = objects.sharedManager.fetchedBookings[btnTag].docId
        dataToPost.sharedManager.updateId = uid
        dataToPost.sharedManager.updateIndex = btnTag
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "barberSelect")
//        self.present(vc!, animated: true, completion: nil)
        self.tabBarController?.selectedIndex = 1;


    }
     var  refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableEvents.reloadData()
        print("fetched bookings: \(objects.sharedManager.fetchedBookings)")
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        //tableEvents.addSubview(refreshControl) // not required when using UITableViewController
        tableEvents.refreshControl = refreshControl
                // Do any additional setup after loading the view.
    }
    @objc func refresh(sender:AnyObject) {
        fetchingData2(completion : {  success in
            self.tableEvents.reloadData()
        })
        refreshControl.endRefreshing()

    }
    override func viewDidAppear(_ animated: Bool) {
        
        if(dataToPost.sharedManager.switchToEventFlag == true){
        fetchingData2(completion : {  success in
//            self.tableEvents.reloadData()
            AnimatableReload.reload(tableView: self.tableEvents, animationDirection: "up")

        })
            
            
        }
        dataToPost.sharedManager.switchToEventFlag = false
        
    }
    
}
