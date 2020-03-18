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
@available(iOS 13.0, *)
class LoginVC: UIViewController {
    
    let titleLabel:UILabel = {
      let label = UILabel()
      label.text = "Wellcome Back!"
      label.font = .boldSystemFont(ofSize: 20.5)
      label.tintColor = .white
      return label
    }()
  
  let imageBackGround:UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "background.jpg")
    image.contentMode = .scaleAspectFill
    return image
  
  }()
  
  let viewBackGround:UIView = {
    let view = UIView()
    view.alpha = 0.9
    view.backgroundColor = #colorLiteral(red: 0.3703024387, green: 0.3008799851, blue: 0.2160971463, alpha: 1)
    return view
    
  }()
  
  let messageLabel:UILabel = {
    
    let label = UILabel()
    label.text = "Login to continue Bookde"
    label.tintColor = .white
    return label
    
    
  }()
    
    let emailTxt: UITextField = {
      let txt = UITextField()
      txt.backgroundColor = .gray
      txt.placeholder = "Email Adress"
      return txt
    }()
    
    let passwordTxt: UITextField = {
      let txt = UITextField()
      txt.placeholder = "Pass world"
      return txt
      
    }()
  
  let loginButton:UIButton = {
  
    let btn = UIButton()
    
    btn.setTitle("Login", for: .selected)
    btn.backgroundColor = #colorLiteral(red: 1, green: 0.7943956852, blue: 0, alpha: 1)
    btn.tintColor = .white
    return btn
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
    
    self.view.addSubview(imageBackGround)
    imageBackGround.addSubview(viewBackGround)
    viewBackGround.addSubview(titleLabel)
    viewBackGround.addSubview(messageLabel)
    viewBackGround.addSubview(emailTxt)
    viewBackGround.addSubview(passwordTxt)
    viewBackGround.addSubview(loginButton)
    imageBackGround.snp.makeConstraints { (make) in
      make.trailing.equalTo(self.view).inset(0)
      make.leading.equalTo(self.view).inset(0)
      make.top.equalTo(self.view).inset(0)
      make.bottom.equalTo(self.view).inset(0)
    }
    
    viewBackGround.snp.makeConstraints { (make) in
      make.trailing.equalTo(self.view).inset(0)
      make.leading.equalTo(self.view).inset(0)
      make.top.equalTo(self.view).inset(0)
      make.bottom.equalTo(self.view).inset(0)
      
    }
//    self.view.backgroundColor = .gray
//    self.view.addSubview(titleLabel)
//    self.view.addSubview(messageLabel)
//    self.view.addSubview(emailTxt)
    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.viewBackGround).inset(50)
      make.centerX.equalTo(self.viewBackGround)

    }
    

    messageLabel.snp.makeConstraints { (make) in
          make.top.equalTo(self.titleLabel).inset(50)
          make.centerX.equalTo(self.viewBackGround)

    }
//
      emailTxt.snp.makeConstraints { (make) in
          make.top.equalTo(messageLabel).inset(50)
          make.leading.equalTo(self.viewBackGround).inset(20)
          make.trailing.equalTo(self.viewBackGround).inset(20)
          make.height.equalTo(50)
        }
    
    passwordTxt.snp.makeConstraints { (make) in
      make.top.equalTo(emailTxt).inset(30)
      make.leading.equalTo(self.viewBackGround).inset(20)
      make.trailing.equalTo(self.viewBackGround).inset(20)
      make.height.equalTo(50)
    }
    
    loginButton.snp.makeConstraints { (make) in
      make.top.equalTo(passwordTxt).offset(30)
      make.leading.equalTo(self.passwordTxt)
      make.trailing.equalTo(self.passwordTxt)
      make.height.equalTo(50)
      
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
