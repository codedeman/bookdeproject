//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 11/9/23.
//

import SwiftUI

public struct NewMessageView: View {

    @ObservedObject var viewModel: NewMessageViewModel
    @EnvironmentObject var messageState: NewMessageState

    public init (viewModel: NewMessageViewModel) {
        self.viewModel = viewModel
    }

    @State var textMessage: String = ""
    public var body: some View {
        ZStack {
            messageView
        }.onAppear(perform: {
            Task {
              await viewModel.fetchMessage(toId: messageState.user?.uiid ?? "")
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
            Image(systemName: "gear")
            TextField("Description", text: $viewModel.text)
            Button {
                viewModel.sendMessage(toId: messageState.user?.uiid ?? "")
            }label: {
                Text("Send").foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(Color.blue)
                .cornerRadius(8)

        }.padding()
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
