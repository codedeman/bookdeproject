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
    private var subscribers: [AnyCancellable] = []
    @Published var state: State
    @Published public var isSignOut: Bool = false

    public init(useCase: MessageUseCase) {
        self.useCase = useCase
        self.state = .loading
        Task {
            await fetch()

        }
    }

    enum HeaderSection: Equatable, Identifiable {
        var id: UUID {
            return UUID()
        }

        case currentUser(User)
    }

    enum BodySection: Equatable, Identifiable {

        var id: UUID {
            return UUID()
        }

        case general([User])
    }

    enum State {
        case loading
        case body(_ users: [User])
    }

    private func fetch() async {
        state = .loading
//        await useCase.fetchCurrentUser()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: {  [weak self] user in
//                
//            })
//            .store(in: &subscribers)
//        await useCase.fetchAllUser()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: {  [weak self] user in
//                self?.state = .body(user)
//            })
//            .store(in: &subscribers)
    }

    func signOut() async {
            await useCase.signOut()
                .assign(to: &$isSignOut)
    }

}