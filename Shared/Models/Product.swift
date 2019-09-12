//
//  Product.swift
//  Bookde
//
//  Created by Apple on 6/18/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Product {
    
    var nameProduct:String
    var productBrand:String
    var id:String
    var category:String
    var price:Double
    var productDescription:String
    var imageUrl:String
    var timeStamp:Timestamp
    
//    var favorite:Bool
    
    init(data:[String:Any]) {
        
        
        self.nameProduct = data["nameProduct"] as? String ?? ""
        
        self.imageUrl = data["imageURL"] as? String ?? ""
        
        self.productDescription = data["productDescription"] as? String ?? ""
        self.price = data["price"] as? Double ?? 0.0
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        self.id  = data["id"] as? String ?? ""
        
        self.category = data["category"] as? String ?? ""
        self.productBrand = data["productBrand"] as? String ?? ""
        
        
    }

}




