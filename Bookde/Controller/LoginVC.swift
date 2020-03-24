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
    var gradientLayer: CAGradientLayer!
  
    let titleLabel:UILabel = {
      let label = UILabel()
      label.text = "Wellcome Back!"
      label.textColor = .white
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
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    view.alpha = 0.8
    return view
    
  }()
  
  let messageLabel:UILabel = {
    
    let label = UILabel()
    label.textColor = .white
    label.text = "Login to continue Bookde"
    label.tintColor = .white
    return label
    
    
  }()
    
    let emailTxt: UITextField = {
      let txt = UITextField()
      txt.backgroundColor = .white
      txt.borderStyle = .roundedRect
      txt.placeholder = "Email Adress"
      return txt
    }()
    
    let passwordTxt: UITextField = {
     let txt = UITextField()
      txt.backgroundColor = .white
      txt.isSecureTextEntry = true
      txt.borderStyle = .roundedRect
      txt.placeholder = "Pass world"
      return txt
      
    }()
  
  let loginButton:UIButton = {
  
    let btn = UIButton()
    btn.setTitle("Login", for: .normal)
    btn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    btn.tintColor = .white
    return btn
  }()
  
  let forgotPassWorldButton:UIButton = {
    
    let btn = UIButton()
    btn.setTitle("Forgot passworld ", for: .normal)
//    btn.backgroundColor = .clear
    btn.tintColor = .yellow
    return btn
  }()
  
    
    let activityIndicator: UIActivityIndicatorView = {
  
      let activity = UIActivityIndicatorView()
      activity.color = .red
      
      return activity
    }()
    
 
  
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.viewBackGround.bounds
     
      gradientLayer.colors = [UIColor.orange.cgColor,UIColor.red.cgColor]
     
        self.viewBackGround.layer.addSublayer(gradientLayer)
    }
  
  @objc func loginBtnWasPressed(){
    
    
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
      initUI()
//        gradientLayer = CAGradientLayer()
//        gradientLayer.frame = imageBackGround.bounds
//        gradientLayer.colors = [UIColor.orange.cgColor,UIColor.red.cgColor]
//        imageBackGround.layer.addSublayer(gradientLayer)
      
      viewBackGround.backgroundColor = #colorLiteral(red: 0.4030454755, green: 0.2138568461, blue: 0, alpha: 1)
      
      
      loginButton.addTarget(self, action: #selector(loginBtnWasPressed), for: .allEvents)
      forgotPassWorldButton.addTarget(self, action: #selector(passworldBtnWasPressed), for: .allEvents)
        // Do any additional setup after loading the view.
    }
  
  
  @objc func passworldBtnWasPressed(){
    
    let vc  = ForgotPasswordVC()
    vc.modalTransitionStyle = .crossDissolve
    vc.modalPresentationStyle = .overCurrentContext
    present(vc, animated: true, completion: nil)

  
  }
  
  
  func initUI(){
    navigationController?.setToolbarHidden(true, animated: true)
    
    self.view.addSubview(imageBackGround)
    imageBackGround.addSubview(viewBackGround)
    imageBackGround.addSubview(titleLabel)
    imageBackGround.addSubview(messageLabel)
    view.addSubview(emailTxt)
    view.addSubview(passwordTxt)
    view.addSubview(loginButton)
    viewBackGround.addSubview(activityIndicator)
    view.addSubview(forgotPassWorldButton)
    imageBackGround.snp.makeConstraints { (make) in
      make.trailing.equalTo(self.view).inset(0)
      make.leading.equalTo(self.view).inset(0)
      make.top.equalTo(self.view).inset(0)
      make.bottom.equalTo(self.view).inset(0)
    }

    viewBackGround.snp.makeConstraints { (make) in
      make.trailing.equalTo(self.imageBackGround).inset(0)
      make.leading.equalTo(self.imageBackGround).inset(0)
      make.top.equalTo(self.imageBackGround).inset(0)
      make.bottom.equalTo(self.imageBackGround).inset(0)
    }

    titleLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.imageBackGround).inset(50)
      make.centerX.equalTo(self.imageBackGround)

    }
    

    messageLabel.snp.makeConstraints { (make) in
          make.top.equalTo(self.titleLabel).inset(50)
          make.centerX.equalTo(self.imageBackGround)

    }
    emailTxt.snp.makeConstraints { (make) in
          make.top.equalTo(messageLabel).inset(30)
          make.centerX.equalTo(self.view)
          make.leading.equalTo(self.view).offset(20)
          make.trailing.equalTo(self.view).offset(-20)
          make.height.equalTo(50)
    }

      passwordTxt.snp.makeConstraints { (make) in
        make.top.equalTo(emailTxt).inset(70)
        make.leading.equalTo(self.view).offset(20)
        make.trailing.equalTo(self.view).offset(-20)
        make.height.equalTo(50)
      }
      loginButton.snp.makeConstraints { (make) in
         make.centerX.equalTo(self.view)
        make.top.equalTo(passwordTxt).offset(80)
        make.width.equalTo(passwordTxt)
        make.height.equalTo(50)

      }
    
    activityIndicator.snp.makeConstraints { (make) in
      
      make.centerY.equalTo(self.view)
      make.centerX.equalTo(self.view)
    }
    
    forgotPassWorldButton.snp.makeConstraints { (make) in
      
      make.top.equalTo(self.loginButton).inset(5)
      make.trailing.equalTo(self.loginButton).inset(10)
      make.bottom.equalTo(self.viewBackGround).inset(100)
    }

  }
    
}
