import SwiftUI

struct NavView<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let title: String
    let content: Content

    var body: some View {
        NavigationView {
            VStack {
                NavBar(backHandler: { self.presentationMode.wrappedValue.dismiss() }, title: title)
                content
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct NavBar: View {
    let backHandler: (() -> Void)
    let title: String

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: { self.backHandler() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                            .font(.system(size: 16))
                    }.foregroundColor(Color.blue)
                }
                Spacer()
                Text(title)
                    .font(.system(size: 16))
                    .lineLimit(1)
                    .foregroundColor(Color.white)
                Spacer()
            }.padding([.leading, .trailing], 16)
            Divider()
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .frame(height: 45)
    }
}

public struct MessageHeaderSectionView: View {
    var user: UserChat
    @State var shouldShowLogOutOptions = false
    let didTapLogOut: () -> Void

    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 0) {
                AsyncImage(url: URL(string: user.profileUrl))
                    .frame(width: 24, height: 24)
                    .cornerRadius(64)
                    .foregroundColor(Color.blue)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello, \(user.email)")
                        .font(.system(size: 14, weight: .bold))
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 14, height: 14)
                        Text("online")
                            .font(.system(size: 12))
                }
                Spacer()
                Button {
                    shouldShowLogOutOptions.toggle()
                }label: {
                    Image(systemName: "gear")
                        .font(
                            .system(
                                size: 15,
                                weight: .bold
                            )
                        )
                }

            }.padding()
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Setting"),
                          message: Text("What do you want to do?"),
                          buttons: [
                            .destructive(Text("Sign Out"),
                                         action: {
                                             didTapLogOut()
                                         }),
                            .cancel()

                          ])
                }
        }.background(Color.pink)
    }
}
