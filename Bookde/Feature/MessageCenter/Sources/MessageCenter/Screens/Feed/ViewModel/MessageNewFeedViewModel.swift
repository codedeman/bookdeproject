//
//  MessageNewFeedViewModel.swift
//  
//
//  Created by Kevin on 11/5/23.
//

import Combine
import SwiftUI
import Foundation
import DBCore

@MainActor
final public class MessageNewFeedViewModel: ObservableObject {

    private var useCase: MessageUseCase
    private var subscribers = Set<AnyCancellable>()
    @Published var messageStatus: Status
    @Published var isSignOut: Bool = false
    @Published var user: UserChat = .init(email: "", profileUrl: "", uiid: "")

    public init(useCase: MessageUseCase) {
        self.useCase = useCase
        self.messageStatus = .loading([])
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
        case loading(_ users: [UserChat])
        case body(_ users: [UserChat])
        case stop
    }

    func fetch() async {
        messageStatus = .loading(loadDefaultUsers())
        await useCase.fetchCurrentUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in

            }, receiveValue: { [weak self] user in
                self?.user = user
            }).store(in: &subscribers)
        await useCase.fetchAllUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {  [weak self] user in
                self?.messageStatus = .body(user)
            })
            .store(in: &subscribers)
    }

    func signOut() async {
        await useCase.signOut().assertNoFailure()
                .assign(to: &$isSignOut)
    }

    func createChat(user: UserChat) {
    }

}

extension MessageNewFeedViewModel: ViewModelType {

    public final class Input: ObservableObject {
        var loadTrigger: AnyPublisher<Void, Never>
        init(loadTrigger: AnyPublisher<Void, Never>) {
            self.loadTrigger = loadTrigger
        }

    }

    public final class Output: ObservableObject {
        @Published var currentUser: UserChat?
        @Published var messageStatus: Status?
        @Published var isLoading = false
        @Published var errorMessage: String?

    }

    public func transform(input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        input.loadTrigger
            .handleEvents(receiveOutput: { [weak self] _ in
                output.messageStatus = .loading((self?.loadDefaultUsers())!)
                output.isLoading = true // Show loading indicator
            })
            .flatMap { [weak self] _ -> AnyPublisher<(UserChat, [UserChat]), NSError> in
                guard let self = self else {
                    return Fail<(UserChat, [UserChat]), NSError>(
                        error: NSError(
                            domain: "Deallocated",
                            code: -1, userInfo: nil
                        )
                    )
                    .eraseToAnyPublisher()
                }

                return Future<(UserChat, [UserChat]), NSError> { promise in
                    Task {
                        do {
                            let currentUser = try await self.useCase.fetchCurrentUser()
                                .firstValue() // Using a helper to convert publisher to async value

                            let allUsers = try await self.useCase.fetchAllUser()
                                .firstValue() // Same helper for fetching all us
                                                // Resolve the future with the currentUser and allUsers

                            // Resolve the Future with success, passing the tuple (currentUser, allUsers)
                            promise(.success((currentUser, allUsers)))
                        } catch {
                            output.messageStatus = .stop
                            // If an error occurs, resolve the Future with failure
                            promise(.failure(error as NSError))
                        }
                    }
                }
                .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { completion in
                output.isLoading = false // Hide loading indicator
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    output.errorMessage = error.localizedDescription
                }
            }, receiveValue: { (currentUser, allUsers) in
                // Assign the result to the output
                output.currentUser = currentUser
                output.messageStatus = .body(allUsers)
            })
            .store(in: cancelBag)

        return output
    }

    func loadDefaultUsers() -> [UserChat] {
       let users: [UserChat] = [
           .init(email: "", profileUrl: "", uiid: "123"),
           .init(email: "", profileUrl: "", uiid: "1256"),
           .init(email: "", profileUrl: "", uiid: "124"),
           .init(email: "", profileUrl: "", uiid: "1251"),
           .init(email: "", profileUrl: "", uiid: "126"),
           .init(email: "", profileUrl: "", uiid: "127"),
           .init(email: "", profileUrl: "", uiid: "123"),
           .init(email: "", profileUrl: "", uiid: "1256"),
           .init(email: "", profileUrl: "", uiid: "124"),
           .init(email: "", profileUrl: "", uiid: "1251"),
           .init(email: "", profileUrl: "", uiid: "126"),
           .init(email: "", profileUrl: "", uiid: "127")
       ]
       return users
   }

}

extension Publisher {
    func firstValue() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = self.first()
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel() // Cancel the subscription
                }, receiveValue: { value in
                    continuation.resume(returning: value)
                    cancellable?.cancel() // Cancel the subscription after receiving the first value
                })
        }
    }
}
