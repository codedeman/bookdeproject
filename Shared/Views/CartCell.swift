//
//  CartCell.swift
//  Bookde
//
//  Created by Apple on 6/5/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Kingfisher
class CartCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!{
        didSet{
            
            productImg.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var productDescription: UILabel!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var ratingButton: UIButton!
    
    func configureCell(product:Product) {
        
        productTitle.text = product.nameProduct
        productDescription.text = product.productDescription
        productPrice.text =  String(product.price)
        if let url = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: AppImages.Placeholder)
//            productImg.kf.setImage(with: url)
            productImg.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            productImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
