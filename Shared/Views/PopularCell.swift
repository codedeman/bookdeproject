//
//  PopularCell.swift
//  Bookde
//
//  Created by Apple on 5/9/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Kingfisher


class PopularCell: UICollectionViewCell {

    @IBOutlet weak var imageName: UIImageView!
    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var foodBrand: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var foodPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateView(food:Food)  {
        
        self.foodBrand.text = food.brand
        self.foodPrice.text = String(food.price)
        self.foodName.text = food.brand
        self.imageName.image = UIImage(named: food.imageName)
        
//        if let url = URL(string: food.imageUrl){
//            let placeholder = UIImage(named: "placeholder")
//            
//            let options:KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
//            imageName?.kf.indicatorType = .activity
//            
//            imageName?.kf.setImage(with: url,placeholder: placeholder)
//        }
        
        
    }

}
