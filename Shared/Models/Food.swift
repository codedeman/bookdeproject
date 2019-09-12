//
//  Feed.swift
//  Bookde
//
//  Created by Apple on 5/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

struct Food {
    private(set) public  var brand:String
    private(set) public  var price:Float
    private(set) public  var title:String
    private(set) public  var imageName:String
    
    init(title:String,price:Float,brand:String,imageName:String) {
        
        self.title =  title
        self.price =  price
        self.imageName = imageName
        self.brand =  brand
    }
    




}
