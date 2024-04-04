//
//  UserProfile.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import UIKit

public struct UserProfile: Equatable, Hashable {
    public var providerID: String?

    public var uid: String = ""

    public var displayName: String?

    public var photoURL: URL?

    public var email: String?

    public var phoneNumber: String?
    public init(
        providerID: String? = nil,
        uid: String, displayName: String? = nil,
        photoURL: URL? = nil,
        email: String? = nil,
        phoneNumber: String? = nil
    ) {
        self.providerID = providerID
        self.uid = uid
        self.displayName = displayName
        self.photoURL = photoURL
        self.email = email
        self.phoneNumber = phoneNumber
    }

}

