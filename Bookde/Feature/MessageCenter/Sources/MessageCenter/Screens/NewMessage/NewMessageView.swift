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

    public init (viewModel: NewMessageViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            messageView
            if viewModel.state == .error {
                ErrorScreenTemplateView()
            }
        }.onAppear(perform: {
            Task {
               viewModel.fetchMessage(toId: messageState.user?.uiid ?? "")
            }
        })


    }

    private var messageView: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.messages) { num in
                    HStack {
                        Spacer()
                        HStack {
                            Text(num.text)
                                .foregroundColor(Color.white)
                        }.padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }.padding(.horizontal)
                        .padding(.top,8)
                }
            }
            HStack{ Spacer() }

        }.ignoresSafeArea()
            .navigationTitle($viewModel.user.email)
            .background(Color(.init(white: 0.95, alpha: 1)))
            .safeAreaInset(edge: .bottom) {
                inputBottom
                    .background(Color(.systemBackground).ignoresSafeArea())
            }
    }

    private var inputBottom: some View {
        HStack {
            Image(systemName: "message")
            TextField("Write a message...", text: $text)
            Button {
                Task {
                   await viewModel.sendMessage(toId: messageState.user?.uiid ?? "",message: text)
                }
            }label: {
                Text("Send").foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical,8)
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
