//
//  File.swift
//  
//
//  Created by Kevin on 10/28/23.
//

import Foundation
import DBCore

public enum AppState: StateManager {
    case startSignUp
    case startHome
    case startSignIn
    case startCreateNewMessage
}
