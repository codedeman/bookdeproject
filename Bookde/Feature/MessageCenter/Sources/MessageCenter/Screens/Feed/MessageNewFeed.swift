//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import SwiftUI
import CoreUI
import Routers
import Combine
import DBCore

public struct MessageFeedView: View {
    @State var shouldShowLogOutOptions = false
    @State private var isLoading = true

    @State var showNewMessage: Bool = false
    @StateObject var viewModel: MessageNewFeedViewModel
    @StateObject var output: MessageNewFeedViewModel.Output
    @StateObject var triggers: Triggers
    @StateObject var cancelBag: CancelBag

    @EnvironmentObject private var router: Router
    let startCreateNewMessage: (UserChat) -> Void

    public init(
        _ shouldShowLogOutOptions: Bool = false,
        viewModel: MessageNewFeedViewModel,
        startCreateNewMessage: @escaping (UserChat) -> Void = {_ in  }
    ) {
        let cancelBag = CancelBag()
        self.shouldShowLogOutOptions = shouldShowLogOutOptions
        _viewModel = .init(wrappedValue: viewModel)
        self.startCreateNewMessage = startCreateNewMessage
        let triggers = Triggers()
        let input = MessageNewFeedViewModel.Input(
            loadTrigger: triggers.loadingTriggers.eraseToAnyPublisher()
        )

        let output = viewModel.transform(input: input, cancelBag: cancelBag)
        _output = StateObject(wrappedValue: output)
        _triggers = StateObject(wrappedValue: triggers)
        _cancelBag = StateObject(wrappedValue: cancelBag)
        triggers.loadingTriggers.send(())
    }

    public var body: some View {
        ZStack {
            VStack {
                MessageHeaderSectionView(
                    user: output.currentUser ?? .init(email: "", profileUrl: "", uiid: ""),
                    didTapLogOut: {
                        Task {
                            await viewModel.signOut()
                        }
                    }).onReceive(viewModel.$isSignOut, perform: { actiion in
                        if actiion {
                            router.navigateBack()
                        }
                        print("action ==>", actiion)
                    })
                switch  output.messageStatus {
                case .loading(let users):
                    MessageListView(
                        users: users,
                        loading: true,
                        didSelectUser: { user in
                            self.startCreateNewMessage(user)
                        }
                    )
                case .body(let users):
                    MessageListView(
                        users: users,
                        loading: false,
                        didSelectUser: { user in
                            self.startCreateNewMessage(user)
                        }
                    )

                case .stop:
                    Text("Opp Something wrong")
                    Spacer()
                default:
                    EmptyView()
                }
            }.onAppear(perform: {
                triggers.loadingTriggers.send(())
            })

        }.navigationBarHidden(true)

    }

    private var newMessageButton: some View {
        Button {
            showNewMessage.toggle()
        } label: {
            HStack {
                Spacer()
                    Text("+ New Message")
                        .font(.system(size: 16, weight: .bold))
                Spacer()

            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }.fullScreenCover(isPresented: $showNewMessage, content: {
            Text ("WellCome")
        })

    }

    final class Triggers: ObservableObject {
        var loadingTriggers = PassthroughSubject<Void, Never>()
    }

}
