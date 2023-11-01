//
//  File.swift
//  
//
//  Created by Kevin on 11/5/23.
//

import Foundation
import DBFireBaseService
import Combine

public protocol MessageUseCase {
    func fetchCurrentUser() async -> AnyPublisher<User, Never>
    func signOut() async -> AnyPublisher<Bool, Never>
}

public final class ImplMessageUseCase: MessageUseCase {
    public func fetchCurrentUser() async -> AnyPublisher<User, Never> {
        let status = await respository.fetchCurrentUser()
        switch status {
        case .success(let document):
            let user = User(
                email: document.email,
                profileUrl: document.profileUrl,
                uiid: document.uiid
            )
            return Just(user).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! Never).eraseToAnyPublisher()
        }
    }
    


    private var respository: FireRepository

    public init(respository: FireRepository = ImplFireRepository())
    {
        self.respository = respository
    }

    public func fetchCurrentUser() async -> AnyPublisher<Result<User, Error>, Never> {
        let status = await respository.fetchCurrentUser()
        switch status {
        case .success(let document):
            let user = User(
                email: document.email,
                profileUrl: document.profileUrl,
                uiid: document.uiid
            )
            return Just(.success(user)).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! Never).eraseToAnyPublisher()
        }
    }

    public func signOut() async -> AnyPublisher<Bool, Never> {
        let isSignOut = await respository.signOut()
        return Just(isSignOut).eraseToAnyPublisher()
    }

}
