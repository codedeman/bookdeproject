//
//  SignInViewController.swift
//  Bookde
//
//  Created by Apple on 3/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    let emailTxt:UITextField = {
      let txt = UITextField()
      txt.borderStyle = .roundedRect
  //    txt.backgroundColor =
      txt.placeholder = "Email Adress"
      return txt
    
    }()
    let activityIndicatorView:UIActivityIndicatorView = {
      let activity = UIActivityIndicatorView()
      activity.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.2156862745, blue: 0.02352941176, alpha: 1)
      return activity
    }()
    
    let passWorldTxt:UITextField = {
      let txt = UITextField()
      txt.borderStyle = .roundedRect
      txt.placeholder = "PassWorld"
      return txt
    }()
    let mainView:UIView = {
      let view = UIView()
      view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      view.alpha = 0.8
      return view
    }()
    let imageBackGround:UIImageView = {
      let image = UIImageView()
      image.translatesAutoresizingMaskIntoConstraints = false
      image.image = UIImage(named: "food.jpg" )
      return image
    }()
    
    let loginButton:UIButton = {
      let btn = UIButton()
      btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
      btn.tintColor = .white
      btn.setTitle("Sign In", for: .normal)
      
      return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
