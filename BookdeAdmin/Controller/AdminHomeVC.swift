//
//  AdminHomeVC.swift
//  BookdeAdmin
//
//  Created by Apple on 6/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AdminHomeVC: NewFeedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.leftBarButtonItem?.isEnabled = false
        let addCategoryBtn = UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory))
        navigationItem.rightBarButtonItem = addCategoryBtn
        
      

        // Do any additional setup after loading the view.
    }
    
    @objc func addCategory(){
        
        performSegue(withIdentifier: Segues.ToAddEditCategory, sender: self)
        
        
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
