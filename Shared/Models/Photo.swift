//
//  Photo.swift
//  Bookde
//
//  Created by Apple on 5/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
struct Photo {
    private(set) public  var food:String
    private(set) public var restaurant:String
    private(set) public var image: UIImage
    
    init(food:String,restaurant:String,image:UIImage) {
        
        self.food = food
        self.restaurant = restaurant
        self.image =  image
    }
    

}
