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

    func signUp(
        _ email: String,
        password: String,
        passworlConfirm: String,
        imageProfile: Data?
    ) async {

        let user = await useCase.signUp(
            email: email,
            passworld: password,
            imageData: imageProfile
        )

       user.sink { [self] result in
            switch result {
            case .success(let user):
                print("user id: \(user.uid)")
            case .failure(let error):
                print("error *** \(error)")
//                state = .finished
            }
        }

    }

    func didTabHaveAccount() {
        state = .finished
    }

    func didTabOpenPhotos() {

    }

}
