//
//  AppFlowView.swift
//
//
//  Created by Kevin on 10/24/23.
//

import Authenticate
import CoreUI
import DBService
import FirebaseAuth
import Home
import MessageCenter
import Routers
import SwiftUI

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
                .navigationDestination(for: AuthenticateState.self) { state in
                    EmptyView()

                switch state {
                case .startNewFeed:
                    MessageFeedView(viewModel: appCondinator.messageViewModel())
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
        }.environmentObject(router)
    }
}
