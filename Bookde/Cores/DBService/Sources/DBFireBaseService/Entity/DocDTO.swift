//
//  DocDTO.swift
//  
//
//  Created by Kevin on 11/6/23.
//

import UIKit
import FirebaseStorage

public struct DocumentDTO {

    public var email: String
    public var profileUrl: String
    public var uiid: String

    init(dic: [String: Any]) {
        email = dic["email"] as? String ?? ""
        profileUrl = dic["profileUrl"] as? String ?? ""
        uiid = dic["uiid"] as? String ?? ""
    }
}
