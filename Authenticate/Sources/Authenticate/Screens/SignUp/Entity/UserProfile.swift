//
//  UserProfile.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import UIKit
import FirebaseAuth
public struct UserProfile: Codable {
    public var providerID: String?

    public var uid: String = ""

    public var displayName: String?

    public var photoURL: URL?

    public var email: String?

    public var phoneNumber: String?



}

