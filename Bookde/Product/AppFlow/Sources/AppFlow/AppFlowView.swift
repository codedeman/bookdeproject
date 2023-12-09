//
//  AppFlowView.swift
//  
//
//  Created by Kevin on 10/24/23.
//

import SwiftUI
import Authenticate
import DBService
import FirebaseAuth
import Home
import MessageCenter
import CoreUI

public struct AppView: View {
    @StateObject var appCondinator: AppStateManager = .init()
    @State private var showingHome = false
    @State private var showingMessageCenter = false
    @State private var showingError = false
    @State  var appState: AppState = .startSignIn

    public init(flow: AppStateManager) {
        self._appCondinator = StateObject(wrappedValue: flow)
    }

    public var body: some View {
        NavigationView {
            ZStack {
                SignInView(
                    viewModel: appCondinator.signInViewModel()
                )
                .environmentObject(
                    appCondinator.myAuthState
                )

            }
        }.onReceive(appCondinator.myAppState.$appState, perform: { state in
            switch state {
            case .startSignUp:
                break
            case .startHome:
                break
            case .startSignIn:
                break
            case .startCreateNewMessage(user: let user):
                showingError = !user.uiid.isEmpty
                break

            }

        }).sheet(isPresented: $showingError, content: {
            ErrorScreenTemplateView()
        })
    }
}

extension AppState {
    func toNavigationPath() -> NavigationPath {
        switch self {
        case .startSignIn:
            return NavigationPath.init()
        case .startHome:
            return NavigationPath(["Home"])
        case .startCreateNewMessage(let user):
            return NavigationPath(["Home", "CreateNewMessage", user.uiid])
            // ... convert other states to NavigationPath
        case .startSignUp:
            return NavigationPath(["Home"])
        }
    }
}
