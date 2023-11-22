import SwiftUI
import DBCore
import PhotosUI
import UIKit

public struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var passworldConfirm = ""

    @ObservedObject var viewModel: SignUpViewModel

    @State var isShowPicker: Bool = false
    @State private var avatarItem: PhotosPickerItem?

    @State private var avatarImage: Image?

    func imageToBinding(_ image: UIImage) -> Binding<Image?> {
      Binding(
        get: {
          avatarImage
        },
        set: { newImage in
          avatarImage = newImage
        }
      )
    }


    public init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            VStack {
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
                .gesture(TapGesture().onEnded {
                    self.isShowPicker = true
                })
                
                TextField("Your email @gmail.com", text: self.$email)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                
                SecureField("Confirm your Password", text: self.$passworldConfirm)
                    .padding()
                    .background(Color.themeTextField)
                    .cornerRadius(20.0)
                
                Button(action: {
                    Task {
                        await signUp()
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
            }.sheet(isPresented: $isShowPicker) {
                ImagePicker(image: $avatarImage)
            }.navigationTitle("")
        }
    }

    private func signUp() async {
        let image = avatarImage?.getUIImage(newSize: .zero)
        let imagedata = image?.jpegData(compressionQuality: 0.8)
        await viewModel.signUp(
            email,
            password: password,
            passworlConfirm: passworldConfirm,
            imageProfile: imagedata
        )
    }

}

extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}

extension Image {
    @MainActor
    func getUIImage(newSize: CGSize) -> UIImage? {
        let image = resizable()
            .scaledToFill()
            .frame(width: newSize.width, height: newSize.height)
            .clipped()
        return ImageRenderer(content: image).uiImage
    }
}
