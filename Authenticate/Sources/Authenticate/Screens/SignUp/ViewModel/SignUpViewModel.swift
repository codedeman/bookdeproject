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
    @Published var profile:UserProfile?

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
//            if case .success(let userProfile) = user {
//                self.profile = userProfile
//            } else if case .failure(let error) = user {
//                // Handle the error case if needed
//                print("Signup failed with error: \(error)")
//            }

//       user.sink { [self] result in
//            switch result {
//            case .success(let user):
//                print("user id: \(user.uid)")
//                state = .finished
//            case .failure(let error):
//                print("error *** \(error)")
//            }
//       }.store(in: &su)

    }

    func didTabHaveAccount() {
        state = .finished
    }

    func didTabOpenPhotos() {

    }

}
