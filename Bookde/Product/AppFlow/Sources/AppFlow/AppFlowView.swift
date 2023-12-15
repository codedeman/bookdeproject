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
import Routers

public struct AppView: View {
    @StateObject var appCondinator: AppStateManager = .init()
    @State private var showingHome = false
    @State private var showingMessageCenter = false
    @State private var showingError = false
    @ObservedObject var router = Router()

    public init(flow: AppStateManager) {
        self._appCondinator = StateObject(wrappedValue: flow)
    }

    public var body: some View {
        NavigationStack(path: $router.navPath) {
            SignInView(viewModel: appCondinator.signInViewModel())
                .environmentObject(router)
                .navigationDestination(for: AuthenticateState.self) { state in
                    switch state {
                    case .startSignUp:
                        SignUpView(viewModel: appCondinator.signUpViewModel())
                    case .startMessageWithUser(let user):
                        MessageFeedView(viewModel: appCondinator.messageViewModel())
                            .environmentObject(router)
                            .navigationDestination(for: MessageState.self) { state in
                                switch state {
                                case .startCreateNewMessage(let user):
                                    NewMessageView(viewModel: appCondinator.newMesageViewModel(user: user))
                                default:
                                    EmptyView()
                                }
                            }
                    default:
                        EmptyView()
                    }
                }
        }

    }
}
