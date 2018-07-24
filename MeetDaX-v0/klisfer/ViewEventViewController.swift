//
//  ViewEventViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 15/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class ViewEventViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let list = ["barber1" , "barber2" ,"barber3" ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewEventTableViewCell
        cell.textviw.text = list[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
