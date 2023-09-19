//
//  File.swift
//  
//
//  Created by Kevin on 10/22/23.
//

import Foundation
import Combine

public final class SignInViewModel: ObservableObject {

    private let useCase: SignUpUseCase
    @Published public var userProfile: UserProfile?
    @Published var isLoading: Bool = false

    @Published public var sate: AuthenticateState?

    public init(useCase: SignUpUseCase) {
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
        self.sate = .startSignUp
    }

    private func handleSignUpSuccess(_ user: UserProfile) {
        DispatchQueue.main.async {
            self.userProfile = user
            self.isLoading = false
        }
    }

    private func handleSignUpFailure(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }


}
