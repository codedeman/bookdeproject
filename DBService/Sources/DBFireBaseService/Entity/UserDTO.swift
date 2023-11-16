//
//  File.swift
//  
//
//  Created by Kevin on 10/31/23.
//

import Foundation
import FirebaseAuth

public struct UserDTO {

    public var providerID: String?

    public var uid: String = ""

    public var displayName: String?

    public var photoURL: URL?

    public var email: String?

    public var phoneNumber: String?

    public var description: String?

    public init(
        providerID: String? = nil,
        uid: String,
        displayName: String? = nil,
        photoURL: URL? = nil,
        email: String? = nil,
        phoneNumber: String? = nil,
        description: String? = nil
    ) {
        self.providerID = providerID
        self.uid = uid
        self.displayName = displayName
        self.photoURL = photoURL
        self.email = email
        self.phoneNumber = phoneNumber
        self.description = description
    }

    public static func mapper(user: AuthDataResult) -> Self {
        return .init(
            uid: user.user.uid,
            displayName: user.user.displayName,
            photoURL: user.user.photoURL,
            phoneNumber: user.user.phoneNumber
        )
    }

}



