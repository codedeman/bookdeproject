//
//  File.swift
//  
//
//  Created by Kevin on 8/9/23.
//

import Foundation
import DBService
public struct ListFilm: Codable,Identifiable {
    var listFilms: [Movies]?
    public let id = UUID()

    public init(listFilms: [Movies]? = nil) {
        self.listFilms = listFilms
    }
    
}

public struct Movies: Codable, Identifiable,Hashable {
    public var id : String
    var filmUrl : String
    var name: String

    public init(id: String, filmUrl: String, name: String) {
        self.id = id
        self.filmUrl = filmUrl
        self.name = name
    }
}
