//
//  SwiftUIView.swift
//
//
//  Created by Kevin on 10/22/23.
//

import DBCore
import Routers
import SwiftUI
import AVFAudio
import Speech

public struct SignInView: View {
    @State private var email = "K@gmail.com"
    @State private var passworld = "02111997"
    @ObservedObject var viewModel: SignInViewModel
    @EnvironmentObject private var router: Router

    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            TextField("Email", text: self.$email)
                .padding()
                .background(Color.themeTextField)
                .cornerRadius(20.0)

            SecureField("Password", text: self.$passworld)
                .padding()
                .background(Color.themeTextField)
                .cornerRadius(20.0)

            Button(action: {
                Task {
                    await viewModel.signUp(email: email, passworld: passworld)
                }
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }

            Button("Sign up now?") {
                router.navigate(to: AuthenticateState.startSignUp)
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.fetchCurrentUser()
            }
        })
        .onReceive(viewModel.$userProfile, perform: { user in
            guard user != nil else { return }
            router.navigate(to: AuthenticateState.startNewFeed)
        })
    }
}
