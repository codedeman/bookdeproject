//
//  File.swift
//  
//
//  Created by Kevin on 11/14/23.
//

import Foundation
import Combine

public final class NewMessageViewModel: ObservableObject {

    private var usecase: MessageUseCase
    @Published var user: UserChat
    @Published var isSendingSucess: Bool = false
    @Published var state: State = .none

    enum State {
        case error(error: Error)
        case none
    }

    public init(usecase: MessageUseCase,
                user: UserChat) {
        self.usecase = usecase
        self.user = user
        print("user \(user.email) \(user.uiid)")
    }

    @MainActor
    func sendMessage(message: String) async {

        let result = await usecase.send(
            toId: user.uiid,
            message: message
        )
        print("send message", user.email, user.uiid)
        result.assign(to: &$isSendingSucess)

    }
    @Published var messages: [MessageModel]?

    @MainActor
    func fetchMessage() {
        usecase.fetchMessage(toId: user.uiid) { [weak self] result in
            switch result {
            case .success(let messagesDTO):
                let message = messagesDTO
                    .compactMap{$0}
                    .map { MessageModel(
                    toId: $0.toId,
                    fromId: $0.fromId,
                    text: $0.text,
                    timesstamp: $0.timesstamp,
                    documentId: $0.dococumentId)
                }
                print("message count \(message.count)")
                self?.messages = message
            case .failure(let error):
                print("error===> \(error)")
                self?.state = .error(error: error)
            }
        }
    }

}

public final class NewMessageState: ObservableObject {
    @Published public var user: UserChat

    public init(user: UserChat) {
        self.user = user
    }

}
