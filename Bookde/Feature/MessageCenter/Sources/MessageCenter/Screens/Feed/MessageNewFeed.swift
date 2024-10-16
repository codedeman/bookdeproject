//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import SwiftUI
import CoreUI
import Routers

public struct MessageFeedView: View {
    @State var shouldShowLogOutOptions = false
    @State private var isLoading = true

    @State var showNewMessage: Bool = false
    @StateObject var viewModel: MessageNewFeedViewModel
    @EnvironmentObject private var router: Router
    let startCreateNewMessage: (UserChat) -> Void

    public init(
        _ shouldShowLogOutOptions: Bool = false,
        viewModel: MessageNewFeedViewModel,
        startCreateNewMessage: @escaping (UserChat) -> Void = {_ in  }
    ) {
        self.shouldShowLogOutOptions = shouldShowLogOutOptions
        _viewModel = .init(wrappedValue: viewModel)
        self.startCreateNewMessage = startCreateNewMessage
    }

    public var body: some View {
        ZStack {
            VStack {
                MessageHeaderSectionView(
                    user: viewModel.user,
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
                switch viewModel.messageStatus {
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
                }
            }.onAppear(perform: {
                Task {
                    await viewModel.fetch()
                }
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
}
