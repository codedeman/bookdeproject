//
//  MessageModel.swift
//  
//
//  Created by Kevin on 10/28/23.
//

import Foundation
import FirebaseAuth
enum UserType {
    case sender
    case receiver
    func userType() {

    }
}

public struct MessageModel: Identifiable {
    public var id: String { documentId }
    var toId: String
    var fromId: String
    var text: String
    var timesstamp: String
    var documentId: String
}
