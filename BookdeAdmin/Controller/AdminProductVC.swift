//
//  AdminProductVC.swift
//  Bookde
//
//  Created by Apple on 6/30/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AdminProductVC: ProductVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let editCategoryBtn  = UIBarButtonItem(title: "Edit Category", style: .plain, target: self, action: #selector(editCategory))
        
        let newProductBtn  = UIBarButtonItem(title: "+ Product", style: .plain, target: self, action: #selector(newProduct))


        // Do any additional setup after loading the view.
    }
    @objc func editCategory(){
    
    
        performSegue(withIdentifier: Segues.ToEditCategory, sender: self)
    }
    @objc func newProduct(){
        
        performSegue(withIdentifier: Segues.ToAddEditProduct, sender: self)
    
    
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
