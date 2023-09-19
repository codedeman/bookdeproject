//
//  File.swift
//  
//
//  Created by Kevin on 8/21/23.
//

import Foundation
import Combine

public final class SignUpViewModel: ObservableObject {

    private var useCase: SignUpUseCase!
    @Published var userName: String?
    @Published var passworld: String?
    @Published public var state: AuthenticateState?

    public init(useCase: SignUpUseCase) {
        self.useCase = useCase
    }

    struct Input {

    }

    func signUp(
        _ email: String,
        password: String
    ) async {
        
        let user = await useCase.signUp(email: email, passworld: password)
        // Store a reference to the AnyCancellable object that is returned by the sink() operator.
        let cancellable = user.sink { [self] result in
            switch result {
            case .success(_):
                state = .finished
            case .failure(let error):
                state = .finished
            }
        }

        // Cancel the subscription when the function deinitializes.
        defer { cancellable.cancel() }
    }

    func didTabHaveAccount() {
        state = .finished
    }

    func didTabOpenPhotos() {

    }

}
