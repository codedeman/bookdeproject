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
    @Published var isLoading: Bool = false
    var hasFetchedUser = false

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
    }

    private func handleSignUpSuccess(_ user: UserProfile) {
        self.userProfile = user
        self.isLoading = false
    }

    private func handleSignUpFailure(_ error: Error) {
        self.isLoading = false
    }

    func fetchCurrentUser() async  {
        self.isLoading = true
        let currentUser =  await self.useCase.fetchCurrentUser()
        switch currentUser {
        case .success(let user):
            self.isLoading = false
            self.userProfile = user
        case .failure(_):
            break
        }
    }

}
