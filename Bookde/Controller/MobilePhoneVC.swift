//
//  MobilePhoneVC.swift
//  Bookde
//
//  Created by Apple on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Firebase

class MobilePhoneVC: UIViewController,UITextFieldDelegate {
    
    var firstName:String!
    var lastName:String!
    var passWord:String!
    
    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func continueBtnWasPressed(_ sender: Any) {
        
        activityIndicator.startAnimating()
        guard let authUser = Auth.auth().currentUser else {
            return
        }
//        let credential = EmailAuthProvider.credential(withEmail: email, password: password)

        let credential = EmailAuthProvider.credential(withEmail: firstName, password: passWord)
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                debugPrint(error)
                
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
        
        }
        
    
    }
    
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
   
    

    

}
