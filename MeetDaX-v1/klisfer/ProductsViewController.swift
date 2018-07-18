//
//  ProductsViewController.swift
//  klisfer
//
//  Created by aayush chaubey on 22/03/18.
//  Copyright © 2018 aayush chaubey. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
   let delegate = UIApplication.shared.delegate as! AppDelegate
    //let products = ["products_1" , "products_2"  , "products_3" ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.delegate.prod_name.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2" , for: indexPath) as! ProductsTableViewCell
        //cell.productImage.image = UIImage(named: (products[indexPath.row]))
        cell.productName.text = self.delegate.prod_name[indexPath.row]
        cell.productDescription.text = self.delegate.prod_desc[indexPath.row]
        cell.productPrice.text = self.delegate.prod_price[indexPath.row]
        let imgUrl = delegate.prod_img_url[indexPath.row]
        let url = URL(string: imgUrl)
        cell.productImage.kf.setImage(with: url)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
