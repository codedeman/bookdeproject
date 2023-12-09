//
//  User.swift
//  
//
//  Created by Kevin on 11/6/23.
//

import Foundation

public struct UserChat: Hashable, Equatable, Identifiable {
    public var id: String { uiid }
    public var email: String
    public var profileUrl: String 
    public var uiid: String = ""

    public init(email: String, profileUrl: String, uiid: String) {
        self.email = email
        self.profileUrl = profileUrl
        self.uiid = uiid
    }
}

