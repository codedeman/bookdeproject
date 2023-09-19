
import SwiftUI

public struct SignUpView: View {
    @State private var email = ""
    @State private var passworld = ""
    @ObservedObject var viewModel: SignUpViewModel


    public init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VStack {
            TextField("Email", text: self.$email)
                .padding()
                .background()
                .cornerRadius(20)

            SecureField("PasWorld", text: self.$passworld)
                .padding()
                .background()
                .cornerRadius(20)

            Button("Sign In") {

//                viewModel.signIn(email, passworld: passworld)
            }.task {
                await viewModel.signIn(email, passworld: passworld)
            }
        }.padding([.leading,.trailing], 27.5)
            .background(
                LinearGradient(
                    gradient: .init(colors: [.purple,.blue]),
                    startPoint: .top, endPoint: .bottom
                )
            )
    }
}

//struct SignUpView_Preview: PreviewProvider {
//    static var previews: some View {
////        SignUpView(viewModel: SignUpViewModel)
//    }
//}
