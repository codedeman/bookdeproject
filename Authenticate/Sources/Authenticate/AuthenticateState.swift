//
//  AuthenticateState.swift
//  
//
//  Created by Kevin on 10/28/23.
//

import UIKit
import DBCore
import SwiftUI

public enum AuthenticateState: StateManager {
    case startSignUp
    case finished
    case none
    case userAuthenticated
}

public final class MyAuthenticateState: ObservableObject {

    @Published public var id: String = ""
    @Published public var didSelectBack = false
    @Published public var state: AuthenticateState = .none

    public init(id: String) {
        self.id = id
    }

}
