import SwiftUI
import DBCore
import PhotosUI

public struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var viewModel: SignUpViewModel

    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    public init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            VStack {


                PhotosPicker("select", selection: $avatarItem, matching: .images)
                    .onTapGesture {
                    Task {
                        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                avatarImage = Image(uiImage: uiImage)
                                return
                            }
                        }
                    }

                }

                VStack {
                    if let avatarItem = avatarImage {
                        avatarItem
                            .resizable()
                            .frame(width: 130, height: 130)
                            .scaledToFill()
                            .cornerRadius(64)
                            .foregroundColor(Color.blue)
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 130, height: 130)
                            .scaledToFill()
                            .cornerRadius(64)
                            .foregroundColor(Color.blue)
                    }
                }

                TextField("Your email @gmail.com", text: self.$email)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)

                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)

                SecureField("Confirm your Password", text: self.$password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)

                Button(action: {
                    Task {
                        await viewModel.signUp(email, password: password)
                    }
                }) {
                    Text("Sign up now?")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }

                Button("Already have an account?") {
                    viewModel.didTabHaveAccount()
                }
            }
        }
        .navigationTitle("Welcome to Bookde.com")
    }
}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
