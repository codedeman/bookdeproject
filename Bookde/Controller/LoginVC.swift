//
//  LoginVC.swift
//  Bookde
//
//  Created by Apple on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
class LoginVC: UIViewController {
    
    let titleLabel:UILabel = {
      let label = UILabel()
      label.text = "Wellcome Back!"
      label.font = .boldSystemFont(ofSize: 20.5)
      label.tintColor = .white
      return label
    }()
  
  let messageLabel:UILabel = {
    
    let label = UILabel()
    label.text = "Login to continue Bookde"
    label.tintColor = .white
    return label
    
    
  }()
    
    let emailTxt: UITextField = {
      let txt = UITextField()
      txt.placeholder = "Email Adress"
      txt.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      return txt
    }()
    
    let passwordTxt: UITextField = {
      let txt = UITextField()
      txt.placeholder = "Pass world"
      txt.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      return txt
      
    }()
  
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func forgotPassWordClicked(_ sender: Any) {
        let vc  = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
//        presentationController
        present(vc, animated: true, completion: nil)

        
        
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailTxt.text , email.isNotEmpty ,
            let password = passwordTxt.text , password.isNotEmpty else {
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) { (user, error) in
            
            if let error = error{
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                self.activityIndicator.stopAnimating()
                return
            
            }
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
            
        }
    
        
        
    }
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
      creatView()
        // Do any additional setup after loading the view.
    }
  
  
  func creatView(){
    navigationController?.setToolbarHidden(true, animated: true)
    self.view.backgroundColor = .gray
    self.view.addSubview(titleLabel)
    self.view.addSubview(messageLabel)
    
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.view).inset(40)
      make.leading.equalTo(view).inset(20)
      make.trailing.equalTo(view).inset(20)
      make.height.equalTo(100)
      
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
