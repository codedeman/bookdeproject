//
//  AnnotatedPhotoCell.swift
//  Bookde
//
//  Created by Apple on 5/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBOutlet weak var restaurantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    func updateView(item:Photo)  {
        
        imageView.image = item.image
        foodLabel.text = item.food
        restaurantLabel.text = item.restaurant
    }
    
    
    
}
