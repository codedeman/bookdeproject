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
    @Published var text: String = ""

    public init(usecase: MessageUseCase,user: UserChat) {
        self.usecase = usecase
        self.user = user
    }

    @MainActor
    func sendMessage(toId: String) {
        usecase.send(toId: user.uiid, messgage: text)
    }
    @Published var messages: [MessageModel] = []

    @MainActor
    func fetchMessage(toId: String) async {
        let message = await usecase.fetchMessage(toId: toId)
        message.assertNoFailure().assign(to: &$messages)
    }

}


public final class NewMessageState: ObservableObject {
    @Published public var user: UserChat?

    public init(user: UserChat?) {
        self.user = user
    }

}
