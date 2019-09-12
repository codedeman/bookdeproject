//
//  Category.swift
//  Bookde
//
//  Created by Apple on 6/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct Category {
        var brand:String
        var price:Double
        var description:String
        var imageUrl:String
        var id:String
        var isActive:Bool = true
        var timeStamp:Timestamp


    init(brand:String,
         id:String,
         imageUrl:String,
         isActive:Bool = true,
         timeStamp:Timestamp,
         description:String,
         price:Double) {
        
        
        
            self.brand = brand
            self.id = id
            self.imageUrl = imageUrl
            self.description = description
            self.timeStamp =  timeStamp
            self.isActive = isActive
            self.price = price
        
        
    }

    
    init(data:[String:Any]) {
        
        
        self.brand = data["brand"] as? String ?? ""
        
        self.imageUrl = data["imageURL"] as? String ?? ""
        print("your image \(imageUrl)")
        
        self.description = data["description"] as? String ?? ""
        self.price = Double(data["price"] as? Double ?? 0.0)
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        self.id  = data["id"] as? String ?? ""
        
        
        
    }
    static func modelToData(category:Category)->[String:Any]{
    
        let data:[String:Any] = ["brand":category.brand,
                                 "id":category.id,
                                 "imageURL":category.imageUrl,
                                 "description":category.description,
                                 "price":category.price,
                                 "isActive":category.isActive,
                                 "timeStamp":category.timeStamp
            
                                ]
        
        return data
        
    
    }
    
    
    
    
    
    
}
