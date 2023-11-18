//
//  MessageNewFeedViewModel.swift
//  
//
//  Created by Kevin on 11/5/23.
//

import Combine
import SwiftUI
import Foundation

@MainActor
final public class MessageNewFeedViewModel: ObservableObject {

    private var useCase: MessageUseCase
    private var subscribers = Set<AnyCancellable>()
    @Published var messageStatus: Status
    @Published var isSignOut: Bool = false
    @Published var user: UserChat = .init(email: "", profileUrl: "", uiid: "")
    public var state = CurrentValueSubject<MessageState, Error>(.none)

    public init(useCase: MessageUseCase) {
        self.useCase = useCase
        self.messageStatus = .loading([])
        Task {
//            await fetch()
        }
    }

    enum HeaderSection: Equatable, Identifiable {
        var id: UUID {
            return UUID()
        }

        case currentUser(UserChat)
    }

    enum BodySection: Equatable, Identifiable {

        var id: UUID {
            return UUID()
        }

        case general([UserChat])
    }

    enum Status {
        case loading(_ users:[UserChat])
        case body(_ users: [UserChat])
    }

    func fetch() async {
        messageStatus = .loading(loadDefaultUsers())
        await useCase.fetchCurrentUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {  [weak self] user in
                self?.user = user
            })
            .store(in: &subscribers)
        await useCase.fetchAllUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {  [weak self] user in
                self?.messageStatus = .body(user)
            })
            .store(in: &subscribers)
    }

    private func loadDefaultUsers() -> [UserChat] {
        let users: [UserChat] = [
            .init(email: "", profileUrl: "", uiid: "123"),
            .init(email: "", profileUrl: "", uiid: "1256"),
            .init(email: "", profileUrl: "", uiid: "124"),
            .init(email: "", profileUrl: "", uiid: "1251"),
            .init(email: "", profileUrl: "", uiid: "126"),
            .init(email: "", profileUrl: "", uiid: "127"),
        ]
        return users
    }

    func signOut() async {
            await useCase.signOut()
                .assign(to: &$isSignOut)
    }

    func createChat(user: UserChat) {
        self.state.send(.startCreateNewMessage(users: user))
    }

}
