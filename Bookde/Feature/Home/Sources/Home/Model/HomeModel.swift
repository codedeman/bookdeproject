//
//  File.swift
//  
//
//  Created by Kevin on 6/13/23.
//

import Foundation
import SwiftUI
import CoreLocation

public struct HomeModel: Hashable, Codable, Identifiable {
    public var id: Int
    public var name: String
    public var park: String
    public  var state: String
    public  var description: String
    public  var isFavorite: Bool
    public  var isFeatured: Bool
    public  var subList: [ApartmentRenting] = []
    public var category: Category

    public enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }

    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    private var coordinates: Coordinates

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }


}

public struct ApartmentRenting: Codable, Hashable, Identifiable{
    public var id: Int
    private var imageName: String
    public  var image: Image {
        Image(imageName)
    }
}
