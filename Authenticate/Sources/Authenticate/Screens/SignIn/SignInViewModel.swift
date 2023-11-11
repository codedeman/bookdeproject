//
//  File.swift
//
//
//  Created by Kevin on 10/22/23.
//

import Foundation
import Combine
import DBCore
@MainActor
public final class SignInViewModel: ObservableObject {

    private let useCase: AuthenticateUseCase
    @Published public var userProfile: UserProfile?
    public var state = CurrentValueSubject<AuthenticateState, Error>(.none)
    @Published public var appState: MyAuthenticateState = .init(id: "kevin")

    @Published var isLoading: Bool = false

    public init(useCase: AuthenticateUseCase) {
        self.useCase = useCase
    }

    public func signUp(email: String, passworld: String) async {
        isLoading = true
        let user = await useCase.signIn(email: email, passworld: passworld)
        switch user {
        case .success(let user):
            self.handleSignUpSuccess(user)
        case .failure(let error):
            self.handleSignUpFailure(error)
            break
        }

    }

    public func didTapSignUp() {
        state.send(.startSignUp)
    }

    private func handleSignUpSuccess(_ user: UserProfile) {
        self.userProfile = user
        self.isLoading = false
        state.send(.finished)
        appState.state = .finished
    }

    private func handleSignUpFailure(_ error: Error) {
        self.isLoading = false
    }


}
