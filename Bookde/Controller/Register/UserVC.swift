//
//  UserVC.swift
//  Bookde
//
//  Created by Apple on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class UserVC: UIViewController {
    
    @IBOutlet weak var firstnameTxt: UITextField!
    
    @IBOutlet weak var lastnameTxt: UITextField!
    
    @IBOutlet weak var conditionTxt:UILabel!
    
    @IBAction func continueButtonWasPressed(_ sender: Any) {
        
        checkValue()
        
        
        
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conditionTxt.isHidden =  true

        // Do any additional setup after loading the view.
    }
    
    func checkValue()  {
        
        if firstnameTxt.text!.isEmpty || lastnameTxt.text!.isEmpty{
            
            conditionTxt.isHidden = false
            conditionTxt.text = "Name is required"
        }else{
            
            guard let passwordVC = storyboard?.instantiateViewController(withIdentifier: "PasswordVC") as? PasswordVC else { return }
            
            passwordVC.firstName = firstnameTxt.text
            
            passwordVC.lastName = lastnameTxt.text
            
                present(passwordVC, animated: true, completion: nil)
        }
        
        
        
        
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
