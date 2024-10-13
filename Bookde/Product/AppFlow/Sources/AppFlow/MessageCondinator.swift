//
//  MessageCondinator.swift
//  
//
//  Created by Kevin on 4/11/24.
//

import SwiftUI
import MessageCenter
import Routers
import Authenticate

public struct MessageCondinator: View {
    @EnvironmentObject private var router: Router
    @StateObject var appCondinator: AppStateManager = .init()

    public init(diContainer: AppStateManager) {
        self._appCondinator = StateObject(wrappedValue: diContainer)
    }

    public var body: some View {
            MessageFeedView(viewModel: .init(
                useCase: appCondinator.diContainer.dependencies.mesageUseCase
            )
            ) { user in
                router.navigate(to: MessageState.startCreateNewMessage(users: user))
            }.navigationDestination(for: MessageState.self) { destincation in
                switch destincation {
                case .startCreateNewMessage(let user):
                    NewMessageView(viewModel: appCondinator.newMesageViewModel(user: user))
                case .none:
                    EmptyView()
                case .backToHome:
                    SignInView(viewModel: appCondinator.signInViewModel())
                }
            }
    }

}
