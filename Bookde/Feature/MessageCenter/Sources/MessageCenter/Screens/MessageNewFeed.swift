//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import SwiftUI

public struct MesageFeedView: View {
    @State var shouldShowLogOutOptions = false
    @StateObject var viewModel: MessageNewFeedViewModel
    
    public init(_ shouldShowLogOutOptions: Bool = false, viewModel: MessageNewFeedViewModel) {
        self.shouldShowLogOutOptions = shouldShowLogOutOptions
        _viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack() {
            customNavBar
            messageView

        }.overlay(
            newMessageButton,
            alignment: .bottom)
    }

    private var customNavBar: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                switch viewModel.state {
                case .loading:
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .cornerRadius(64)
                        .foregroundColor(Color.blue)
                case .display(let displaytype):
                    switch displaytype {
                    case .currentUser(let user ):
                        AsyncImage(url: URL(string: user.profileUrl))
                            .frame(width: 24, height: 24)
                            .cornerRadius(64)
                            .foregroundColor(Color.blue)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hello, \(user.email)")
                                .font(.system(size: 14, weight: .bold))
                            HStack(alignment: .top) {
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 14, height: 14)
                                Text("online")
                                    .font(.system(size: 12))
                            }
                        }
                        Spacer()
                        Button {
                            shouldShowLogOutOptions.toggle()
                        }label: {
                            Image(systemName: "gear")
                                .font(.system(size: 15,weight: .bold))
                        }

                    }

                }


            }
        }.padding()
            .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Setting"),message: Text("What do you want to do?"),buttons: [
                    .destructive(Text("Sign Out"),action: {
                        Task {
                            await viewModel.signOut()
                        }
                    }),
                    .cancel()

                ])
            }
    }


    private var messageView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .scaledToFill()
                            .cornerRadius(64)
                            .foregroundColor(Color.blue)
                        VStack(alignment: .leading) {
                            Text("User name")
                                .font(.system(size: 16, weight: .bold))
                            Text("Mesage sent to user")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("22d")
                    }
                    Divider()
                        .padding(.vertical,8)

                }.padding(.horizontal)
            }.padding(.horizontal)
        }
    }

    private var newMessageButton: some View {
        Button {

        } label: {
            HStack {
                    Text("+ New Message")
                        .font(.system(size: 16, weight: .bold))
            }

        }
        .foregroundColor(.white)
        .padding(.vertical)
        .background(Color.blue)
        .cornerRadius(32)
        .padding(.horizontal)
        .shadow(radius: 15)
    }
}


