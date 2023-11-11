//
//  User.swift
//  
//
//  Created by Kevin on 11/6/23.
//

import Foundation
import DBService
import DBFireBaseService

public struct User: Hashable, Equatable, Identifiable {
    public var id: String { uiid }
    var email: String
    var profileUrl: String
    var uiid: String

    init(email: String, profileUrl: String, uiid: String) {
        self.email = email
        self.profileUrl = profileUrl
        self.uiid = uiid
    }
}

extension User {

   
}
