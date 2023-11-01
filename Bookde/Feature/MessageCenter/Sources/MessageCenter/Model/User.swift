//
//  User.swift
//  
//
//  Created by Kevin on 11/6/23.
//

import Foundation

public struct User: Hashable, Equatable {
    var email: String
    var profileUrl: String
    var uiid: String

    init(email: String, profileUrl: String, uiid: String) {
        self.email = email
        self.profileUrl = profileUrl
        self.uiid = uiid
    }
}
