//
//  AuthenticateMock.swift
//  
//
//  Created by Kevin on 11/11/23.
//

import Authenticate
import DBService
import DBFireBaseService
import FirebaseAuth
import DBCore
import Combine

public final class ImplMockAuthenticateUseCase: AuthenticateUseCase {

    private var isSucess: Bool = false

    public init (isSucess: Bool = false) {
        self.isSucess = isSucess
    }


    public func signIn(email: String, passworld: String) async -> Result<UserProfile, AppError> {

        if isSucess {
            let user = UserProfile(providerID: "",
                                   uid: "123",
                                   displayName: "Kevin",
                                   photoURL: nil,
                                   email: email,
                                   phoneNumber: "+6876228828"
            )
            return .success(user)
        } else {

            return .failure(AppError.genericError)
        }


    }

    public func signUp(email: String, passworld: String, imageData: Data?) async -> AnyPublisher<Result<UserProfile, AppError>, Never> {

        if isSucess {
            let userProfile = UserProfile(providerID: "",
                                   uid: "123",
                                   displayName: "Kevin",
                                   photoURL: nil,
                                   email: email,
                                   phoneNumber: "+6876228828"
            )
            return Just(Result.success(userProfile)).eraseToAnyPublisher()

        } else {
            return Just(Result.failure(AppError.genericError)).eraseToAnyPublisher()
        }

    }

    public func fetchCurrentUser() async -> Result<UserProfile, Error> {
        if isSucess {
            let userProfile = UserProfile(providerID: "",
                                   uid: "123",
                                   displayName: "Kevin",
                                   photoURL: nil,
                                   email: "@gmail.com",
                                   phoneNumber: "+6876228828"
            )
            return.success(userProfile)

        } else {
            return .failure(AppError.genericError)
        }
    }


}


