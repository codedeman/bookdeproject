//
//  SignUpUseCase.swift
//  
//
//  Created by Kevin on 8/22/23.
//

import Foundation
import DBService
import DBFireBaseService
import FirebaseAuth
import DBCore
import Combine

public protocol AuthenticateUseCase {
    func signIn(email: String, passworld: String) async -> Result<UserProfile, AppError>
    func signUp(email: String, passworld: String, imageData: Data?) async -> AnyPublisher<Result<UserProfile, AppError>, Never>
}

public final class SignUpUseCaseImpl: AuthenticateUseCase {

    private var firebaseRespository: FireRepository

    public init(firebaseRespository: FireRepository = ImplFireRepository()) {
        self.firebaseRespository = firebaseRespository
    }

    public func signUp(email: String, passworld: String, imageData: Data?) async -> AnyPublisher<Result<UserProfile, AppError>, Never> {

        let data = await firebaseRespository
            .signUpWithEmail(
                email: email,
                passworld: passworld,
                imageProfile: imageData
            )

        switch data {
        case .success(let user):
            let userProfile = UserProfile(
                providerID: user.providerID,
                uid: user.uid,
                displayName: user.displayName
            )
            return Just(Result.success(userProfile)).eraseToAnyPublisher()
        case .failure(_):
            return Just(Result.failure(AppError.genericError)).eraseToAnyPublisher()
        }
    }


    public func signIn(email: String, passworld: String) async -> Result<UserProfile, AppError> {
        let data = await firebaseRespository.signInWithEmail(email: email, passworld: passworld)
        switch data {
        case .success(let user):
            let userProfile = UserProfile(providerID: user.providerID, displayName: user.displayName)
            return .success(userProfile)
        case .failure(_):
            return .failure(AppError.genericError)
        }
    }

}
