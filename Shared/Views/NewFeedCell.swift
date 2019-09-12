//
//  NewFeedCell.swift
//  Bookde
//
//  Created by Apple on 5/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Kingfisher
import Kingfisher


class NewFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodBrand: UILabel!
    @IBOutlet weak var imageName: UIImageView?{
        didSet{
            
            imageName?.layer.cornerRadius = 15
        }
        
    }
    @IBOutlet weak var mainView: UIView?{
        
        didSet{
        
            mainView?.layer.cornerRadius = 15
        
        }
    }
    
    
    @IBOutlet weak var layerEffect: UIVisualEffectView!{
    didSet{
        layerEffect.layer.cornerRadius = 20
        
        
        
        }
    
    }
    override func awakeFromNib() {

    }
    
    func configureCell(category:Category)  {
        
        foodName.text = category.brand
        foodBrand.text = category.description
        foodPrice.text = String(category.price)
        if let url = URL(string: category.imageUrl){
            let placeholder = UIImage(named: "placeholder")
            let options:KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            imageName?.kf.indicatorType = .activity

            imageName?.kf.setImage(with: url,placeholder: placeholder)
        }
        
        
        
    }


}
