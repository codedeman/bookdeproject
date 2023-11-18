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
    public init(usecase: MessageUseCase,user: UserChat) {
        self.usecase = usecase
        self.user = user
    }

    @MainActor
    func sendMessage(toId: String, message: String) async {
       let result = await usecase.send(toId: user.uiid, message: message)
        result.assign(to: &$isSendingSucess)

    }
    @Published var messages: [MessageModel] = []

    @MainActor
    func fetchMessage(toId: String)  {

        usecase.fetchMessage(toId: toId) { [weak self] result in
            switch result {
            case .success(let messagesDTO):
                let message = messagesDTO.map { MessageModel(
                    toId: $0.toId,
                    fromId: $0.fromId,
                    text: $0.text,
                    timesstamp: $0.timesstamp,
                    documentId: $0.dococumentId)
                }
                self?.messages = message
            case .failure(_):
                break
            }
        }
    }

}


public final class NewMessageState: ObservableObject {
    @Published public var user: UserChat?

    public init(user: UserChat?) {
        self.user = user
    }

}
