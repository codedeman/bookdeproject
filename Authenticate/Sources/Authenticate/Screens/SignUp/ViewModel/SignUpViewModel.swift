//
//  File.swift
//  
//
//  Created by Kevin on 8/21/23.
//

import Foundation
import Combine

public final class SignUpViewModel: ObservableObject {

    private var useCase: AuthenticateUseCase!
    @Published var userName: String?
    @Published var passworld: String?
    @Published public var state: AuthenticateState?
    @Published var profile: UserProfile?

    public init(useCase: AuthenticateUseCase) {
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

    }

    func didTabHaveAccount() {
        state = .finished
    }

    func didTabOpenPhotos() {

    }

}
