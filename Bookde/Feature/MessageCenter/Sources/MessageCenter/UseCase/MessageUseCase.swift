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

    func fetchCurrentUser() async -> AnyPublisher<UserChat, Never>
    func signOut() async -> AnyPublisher<Bool, Never>
    func fetchAllUser() async -> AnyPublisher<[UserChat], Never>
    func send(toId:String, messgage: String)
    func fetchMessage(toId: String) async -> AnyPublisher<[MessageModel], Never>
}

public final class ImplMessageUseCase: MessageUseCase {


    private var respository: FireRepository

    public init(respository: FireRepository = ImplFireRepository())
    {
        self.respository = respository
    }

    public func fetchAllUser() async -> AnyPublisher<[UserChat], Never> {
        let status = await respository.fetchAllUsers()
        switch status {
        case .success(let users):
           let userDto = users.map { UserChat(email: $0.email, profileUrl: $0.profileUrl, uiid: $0.uiid) }
            return Just(userDto).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! Never).eraseToAnyPublisher()
        }
    }

    public func fetchCurrentUser() async -> AnyPublisher<UserChat, Never> {
        let status = await respository.fetchCurrentUser()
        switch status {
        case .success(let document):
            let user = UserChat(
                email: document.email,
                profileUrl: document.profileUrl,
                uiid: document.uiid
            )
            return Just(user).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error as! Never).eraseToAnyPublisher()
        }
    }
    

    public func fetchCurrentUser() async -> AnyPublisher<Result<UserChat, Error>, Never> {
        let status = await respository.fetchCurrentUser()
        switch status {
        case .success(let document):
            let user = UserChat(
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

    public func send(toId: String, messgage: String) {
        respository.sendMessage(toId: toId, message: messgage)
    }

    public func fetchMessage(toId: String) async {
        await respository.fetchMessage(toId: toId)
    }

    public func fetchMessage(toId: String) async -> AnyPublisher<[MessageModel], Never> {
        let result = await respository.fetchMessage(toId: toId)
        switch result {
        case .success(let messagesDTO):
            let message = messagesDTO.map { MessageModel(toId: $0.toId, fromId: $0.fromId, text: $0.text, timesstamp: $0.timesstamp) }
            return Just(message).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: (error as? Never)!).eraseToAnyPublisher()
        }
    }

}


