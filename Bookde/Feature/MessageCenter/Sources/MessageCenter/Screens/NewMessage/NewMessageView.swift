//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 11/9/23.
//

import SwiftUI
import CoreUI

public struct NewMessageView: View {

    @ObservedObject var viewModel: NewMessageViewModel
    @EnvironmentObject var messageState: NewMessageState
    @State var text: String = ""

    public init(viewModel: NewMessageViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        messageView
    }

    private var messageView: some View {
            ScrollView {
                ForEach(viewModel.messages ?? [] ) { num in
                    HStack {
                        Spacer()
                        HStack {
                            Text(num.text)
                                .foregroundColor(Color.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
            .background(Color.white) // Move this inside ScrollView if intended.
            .navigationBarTitle(viewModel.user.email) // Use navigationBarTitle directly.
            .background(Color(.init(white: 0.95, alpha: 1)))
            .safeAreaInset(edge: .bottom) {
                inputBottom
                    .background(Color(.systemBackground)
                    .ignoresSafeArea())
            }.onAppear(perform: {
            Task {
                viewModel.fetchMessage()
            }
        })
    }

    private var inputBottom: some View {
        HStack {
            Image(systemName: "message")
            TextField("Write a message...", text: $text)
            Button {
                Task {
                    await viewModel.sendMessage(message: text)
                }
            }label: {
                Text("Send").foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8 )
            .background(Color.blue)
                .cornerRadius(8)

        }.padding().onReceive(viewModel.$isSendingSucess) { complete in
            text = complete ? "" : ""
        }
    }
}

#Preview {
    NewMessageView(
        viewModel: .init(
            usecase: ImplMessageUseCase(),
            user: .init(
                email: "kevin",
                profileUrl: "",
                uiid: ""
            )
        )
    )
}
