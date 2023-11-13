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

public struct AppView: View {
    @StateObject var appCondinator: AppStateManager = .init()
    @State private var showingHome = false
    @State private var showingMessageCenter = false

    public init(flow: AppStateManager) {
        self._appCondinator = StateObject(wrappedValue: flow)
    }

    public var body: some View {
        NavigationStack(path: $appCondinator.appState) {
            VStack {
                SignInView(viewModel: appCondinator.signInViewModel())
            }.navigationDestination(for: AppState.self) { state in
                switch state {
                case .startHome:
                    MessageFeedView(viewModel: appCondinator.messageViewModel())
                case .startSignUp:
                    SignUpView(viewModel: appCondinator.signUpViewModel())
                case .startSignIn:
                    SignInView(viewModel: appCondinator.signInViewModel())
                case .startCreateNewMessage:
                    NewMessageView(viewModel: appCondinator.newMesageViewModel())
                }

            }
        }
    }
}





