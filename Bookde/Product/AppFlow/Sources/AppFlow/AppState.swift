//
//  File.swift
//  
//
//  Created by Kevin on 10/28/23.
//

import Foundation
import DBCore
import MessageCenter
import Combine

public enum AppState: StateManager {

    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch (lhs, rhs) {
          case (.startSignIn, .startSignIn):
              return true
          case (.startSignUp, .startSignUp):
              return true
          case (.startHome, .startHome):
              return true
          case let (.startCreateNewMessage(user: user1), .startCreateNewMessage(user: user2)):
              return user1 == user2
          default:
              return false
          }
    }

    case startSignUp
    case startHome
    case startSignIn
    case startCreateNewMessage(user: UserChat)
}

final class MyAppState: ObservableObject {

    @Published public var appState: AppState = .startSignIn
    init(appState: AppState) {
        self.appState = appState
    }

}
