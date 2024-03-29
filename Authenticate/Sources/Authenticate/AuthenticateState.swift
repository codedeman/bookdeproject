//
//  AuthenticateState.swift
//  
//
//  Created by Kevin on 10/28/23.
//

import UIKit
import DBCore
import SwiftUI
import MessageCenter

public enum AuthenticateState: StateManager {
    case startSignUp
    case finished
    case none
    case userAuthenticated
    case startNewFeed
    case startCreateNewMessage(user: UserChat)

}

public final class MyAuthenticateState: ObservableObject {

    @Published public var id: String = ""
    @Published public var didSelectBack = false
    @Published public var state: AuthenticateState = .none
    @Published public var user: UserProfile?
    public init(id: String) {
        self.id = id
    }

}
