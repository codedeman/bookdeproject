//
//  PasswordVC.swift
//  Bookde
//
//  Created by Apple on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class PasswordVC: UIViewController,UITextFieldDelegate {
    
    var firstName:String!
    var lastName:String!

    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var passwordCondion: UILabel!
    
    @IBAction func continueBtnWasPressed(_ sender: Any) {
        
        checkValue()
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPassTxt.delegate = self
        
        passwordCondion.isHidden = true
        
//        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_textField:)), for: .editingChanged)
//        confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_textField:)), for: .editingChanged)

        // Do any additional setup after loading the view.
    }
    @objc func textFieldDidChange(_textField:UITextField){
        if passwordTxt.text == confirmPassTxt.text{
            
            passwordCondion.isHidden = true
            

            
        }else{
            
            passwordCondion.text = "Password doesn't match"
            passwordCondion.isHidden = false
        }
        
    }
    
    func checkValue()  {
        
        if passwordTxt.text!.isEmpty || confirmPassTxt.text!.isEmpty{
            
            passwordCondion.isHidden = false
            passwordCondion.text = "Password is required"
        }else if passwordTxt.text == confirmPassTxt.text{
            
            passwordCondion.isHidden = true
            
            guard let mobileVC = storyboard?.instantiateViewController(withIdentifier: "MobilePhoneVC") as? MobilePhoneVC else { return }
                    mobileVC.firstName = firstName
                    mobileVC.lastName = lastName
                    mobileVC.passWord = passwordTxt.text
            
                    present(mobileVC, animated: true, completion: nil)
            
            
            
            
        }else{
            
            passwordCondion.text = "Password doesn't match"
            passwordCondion.isHidden = false
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
