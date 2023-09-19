//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 10/22/23.
//

import SwiftUI
import DBCore

public struct SignInView: View {
    @State private var email = "kevin12@gmail.com"
    @State private var passworld = "123456"
    @ObservedObject var viewModel: SignInViewModel

    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            TextField("Email", text: self.$email)
              .padding()
              .background(Color.themeTextField)
              .cornerRadius(20.0)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            }

            SecureField("Password", text: self.$passworld)
              .padding()
              .background(Color.themeTextField)
              .cornerRadius(20.0)

            Button("Sign up now?") {
                viewModel.didTapSignUp()
            }

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

        }
    }
}


//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
////        SignInView(viewModel: SignInViewModel)
//    }
//}

