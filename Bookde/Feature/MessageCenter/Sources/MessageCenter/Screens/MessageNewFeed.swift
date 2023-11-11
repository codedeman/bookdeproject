//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import SwiftUI
import CoreUI

public struct MesageFeedView: View {
    @State var shouldShowLogOutOptions = false
    @State var showNewMessage: Bool = false
    @StateObject var viewModel: MessageNewFeedViewModel
    
    public init(
        _ shouldShowLogOutOptions: Bool = false,
        viewModel: MessageNewFeedViewModel
    ) {
        self.shouldShowLogOutOptions = shouldShowLogOutOptions
        _viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                MessageHeaderSectionView(user: User(email: "kk", profileUrl: "", uiid: ""))
                switch viewModel.state {
                case .loading:
                    MessageListView(
                        users: [
                            .init(email: "", profileUrl: "", uiid: ""),
                            .init(email: "", profileUrl: "", uiid: ""),
                            .init(email: "", profileUrl: "", uiid: ""),
                            .init(email: "", profileUrl: "", uiid: ""),
                            .init(email: "", profileUrl: "", uiid: ""),
                            .init(email: "", profileUrl: "", uiid: ""),
                        ],
                        loading: true
                    )
                case .body(let users):
                   MessageListView(users: users, loading: false)
                }

            }.overlay(
                newMessageButton,
                alignment: .bottom)
        }

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


