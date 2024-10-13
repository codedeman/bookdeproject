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
                    switch state {
                    case .startNewFeed:
                        MessageCondinator(diContainer: appCondinator)
                    case .startSignUp:
                        SignUpView(viewModel: appCondinator.signUpViewModel())
                    default:
                        EmptyView().background(.red)
                    }

                }
        }.environmentObject(router)
    }
}
