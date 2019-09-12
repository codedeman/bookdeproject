//
//  ForgotPasswordVC.swift
//  Bookde
//
//  Created by Apple on 6/15/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    //IBOutlet
    
    @IBOutlet weak var emailTxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelClicked(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetClicked(_ sender: Any) {
       
        guard let email = emailTxt.text, email.isNotEmpty else {
            simpleAlert(title: "Error", msg: "Please enter your .")
            return
        }; Auth.auth().sendPasswordReset(withEmail: emailTxt.text!) { (error) in
            
            if let error = error{
                
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return

            
            }
            self.dismiss(animated: true, completion: nil)

            
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
