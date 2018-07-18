//
//  BookServiceViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 07/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//  barber name = firstName + " " + lastname

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore



class BookServiceViewController: UIViewController {
    
   
    
    
  
    
    
    
    
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    private func setupLayout(){
        /*
         let cardview = UIView()
         cardview.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(cardview)
         cardview.backgroundColor = .gray
         cardview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
         cardview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
         cardview.heightAnchor.constraint(equalToConstant: 100)
         
         
         //textview barber name
         let barberName: UITextView = {
         let textView = UITextView()
         textView.text = "Dorothe Sorensen"
         textView.font = UIFont.boldSystemFont(ofSize: 19)
         textView.translatesAutoresizingMaskIntoConstraints = false
         textView.textAlignment = .center
         textView.isEditable = false
         textView.isScrollEnabled = false
         textView.textColor = .cyan
         return textView
         } ()
         
         
         let barberPic : UIImageView = {
         let imageView = UIImageView(image: #imageLiteral(resourceName: "logo-BW"))
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         return imageView
         }()
         
         cardview.addSubview(barberPic)
         cardview.addSubview(barberName)
         
         
         */
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
