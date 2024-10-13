//
//  File.swift
//
//
//  Created by Kevin on 10/22/23.
//

import Foundation
import Combine
import DBCore

public final class SignInViewModel: ObservableObject {

    private let useCase: AuthenticateUseCase

    public init(useCase: AuthenticateUseCase) {
        self.useCase = useCase
    }

}
extension SignInViewModel: ViewModelType {

    public final class Input: ObservableObject {
        @Published var username = ""
        @Published var password = ""
        let loginTrigger: AnyPublisher<Void, Never>
        init(username: String = "", password: String = "", loginTrigger: AnyPublisher<Void, Never>) {
            self.username = username
            self.password = password
            self.loginTrigger = loginTrigger
        }

    }

    public final class Output: ObservableObject {
        @Published var isLoginEnabled = false
        @Published var isLoading = false
        @Published var usernameValidationMessage = ""
        @Published var passwordValidationMessage = ""
        @Published var userProfile: UserProfile?
        @Published var errorMessage: String?
        @Published var showAllert = false

    }

    public func transform(input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        Publishers.CombineLatest(
            input.$username, input.$password
        ).map { username, password in
            return !username.isEmpty && !password.isEmpty // Simple validation
        }.assign(to: \.isLoginEnabled, on: output)
            .store(in: cancelBag)

        // Handle login trigger
        input.loginTrigger
            .handleEvents(receiveOutput: { _ in
                output.isLoading = true
                // Validate username and password
                let isUsernameValid = self.validateUsername(input.username)
                let isPasswordValid = self.validatePassword(input.password)

                // Update validation messages if invalid
                if !isUsernameValid {
                    output.usernameValidationMessage = "Username is invalid. Please check."
                } else {
                    output.usernameValidationMessage = ""
                }

                if !isPasswordValid {
                    output.passwordValidationMessage = "Password is invalid. Please check."
                } else {
                    output.passwordValidationMessage = ""
                }

            })
            .flatMap { _ in
                Future<Result<UserProfile, AppError>, Never> { promise in
                    Task {
                        let result = await self.useCase.signIn(email: input.username, passworld: input.password)
                        promise(.success(result))
                    }
                }
            }
            .sink { result in
                output.isLoading = false
                switch result {
                case .success(let userProfile):
                    output.userProfile = userProfile
                case .failure(let error):
                    output.showAllert = true
                    output.errorMessage = error.localizedDescription
                }
            }
            .store(in: cancelBag)

        return output

    }

    private func validateUsername(_ username: String) -> Bool {
        return !username.isEmpty && username.count > 3
    }

    private func validatePassword(_ password: String) -> Bool {
        return !password.isEmpty && password.count > 5 // Adjust based on your needs
    }

}
