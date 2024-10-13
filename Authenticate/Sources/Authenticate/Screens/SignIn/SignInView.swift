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
import Combine

public struct SignInView: View {
    // MARK: Property
    @State private var email = "K@gmail.com"
    @State private var passworld = "02111997"
    @ObservedObject var viewModel: SignInViewModel
    @StateObject var input: SignInViewModel.Input
    @StateObject var output: SignInViewModel.Output
    @StateObject var cancelBag: CancelBag
    @StateObject var triggers: Triggers
    @EnvironmentObject private var router: Router

    let navigateNewFeed: () -> Void
    public init(viewModel: SignInViewModel, navigateNewFeed: @escaping () -> Void = {}) {
        self.viewModel = viewModel
        self.navigateNewFeed = navigateNewFeed
        let triggers = Triggers()
        let cancelBag = CancelBag()

        let input = SignInViewModel.Input(
            loginTrigger: triggers.loginTrigger.eraseToAnyPublisher()
        )
        let ouput = viewModel.transform(input: input, cancelBag: cancelBag)

        _input = StateObject(wrappedValue: input)
        _output = StateObject(wrappedValue: ouput)
        _triggers = StateObject(wrappedValue: triggers)
        _cancelBag = StateObject(wrappedValue: cancelBag)

    }

    public var body: some View {
        VStack {
            TextField("Email", text: $input.username)
                .padding()
                .background(Color.themeTextField)
                .cornerRadius(20.0)
            Text(self.output.usernameValidationMessage)
                              .foregroundColor(.red)
                              .font(.footnote)
            SecureField("Password", text: $input.password)
                .padding()
                .background(Color.themeTextField)
                .cornerRadius(20.0)
            Text(self.output.passwordValidationMessage)
                             .foregroundColor(.red)
                             .font(.footnote)

            Button(action: {
                triggers.loginTrigger.send(())
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(!self.output.isLoginEnabled ? Color.gray : Color.blue)
                    .cornerRadius(15.0)

            }.disabled(!self.output.isLoginEnabled)
            .accessibilityIdentifier("loginButton")

            Button("Sign up now?") {
                router.navigate(to: AuthenticateState.startSignUp)
            }
        }
        .onAppear(perform: {
            Task {
            }
        })
        .onReceive(output.$userProfile, perform: { user in
            guard user != nil else { return }
            router.navigate(to: AuthenticateState.startNewFeed)
        })
        .alert(isPresented: $output.showAllert, content: {
            Alert(
                title: Text("Opp"),
                message: Text(output.errorMessage ?? ""),
                dismissButton: .default(Text("OK"))
            )
        })
    }

    final class Triggers: ObservableObject {
        var loginTrigger = PassthroughSubject<Void, Never>()
    }

}
