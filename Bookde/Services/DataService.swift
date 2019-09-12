//
//  DataService.swift
//  Bookde
//
//  Created by Apple on 5/3/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Firebase
class  DataService {
    static let instance = DataService()
    
    
    
    
    
    
//    let foods = [Photo(food: "Pizza", restaurant: "StarBuk", image:UIImage(named: "food2.jpg")!)]
    
    private let product = [Food(title: "Lotte", price: 3.00, brand: "Pizza", imageName: "food3.jpg"),Food(title: "Lotte", price: 3.00, brand: "Pizza", imageName: "food5.jpg"),Food(title: "Lotte", price: 3.00, brand: "Pizza", imageName: "food4.jpg"),Food(title: "Lotte", price: 3.00, brand: "Pizza", imageName: "food4.jpg")]

    private let digitalGoods = [Photo]()

    
//    func getFood() -> [Photo] {
//        
//        return foods
//    }
    
    func getProduct() -> [Food] {
        return product
    }

}
