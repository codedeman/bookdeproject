//
//  ProductDetailVC.swift
//  Bookde
//
//  Created by Apple on 6/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    

    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productBrand: UILabel!
    
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBAction func backWasPressed(_ sender:Any){
    
        dismissDetail()
    
    }
    // variable
    @IBOutlet weak var totalPrice: UILabel!
    
    
    
    var product:Product!
    
    @IBAction func addCartClicked(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        productTitle.text = product.nameProduct
        productBrand.text = product.productBrand
        productDescription.text = product.productDescription
        if let url  = URL(string: product.imageUrl){
            
            productImg.kf.setImage(with: url)
        }
        let formatter = NumberFormatter()
        formatter.numberStyle  = .currency
        if let price = formatter.string(from: product.price as NSNumber){
            
            productPrice.text = price
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(backWasPressed(_:)))
        tap.numberOfTapsRequired = 1
        bgView.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    @objc func backWasPressed(){
    
        dismissDetail()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
