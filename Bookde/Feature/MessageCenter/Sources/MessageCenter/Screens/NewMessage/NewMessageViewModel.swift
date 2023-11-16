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
    @Published var message: String = ""

    public init(usecase: MessageUseCase,user: UserChat) {
        self.usecase = usecase
        self.user = user
    }

    @MainActor
    func sendMessage(toId: String) {
        usecase.send(toId: user.uiid, messgage: message)
    }

    func fetchMessage(toId: String) async {
        await usecase.fetchMessage(toId: toId)
    }

}


public final class NewMessageState: ObservableObject {
    @Published public var user: UserChat?

    public init(user: UserChat?) {
        self.user = user
    }

}
