import SwiftUI

public struct MessageHeaderSectionView: View {
    var user: UserChat
    @State var shouldShowLogOutOptions = false
    let didTapLogOut: () -> ()

    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 16) {
                AsyncImage(url: URL(string: user.profileUrl ?? ""))
                    .frame(width: 24, height: 24)
                    .cornerRadius(64)
                    .foregroundColor(Color.blue).shimmering(active: true)
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

            }.padding()
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Setting"),message: Text("What do you want to do?"),buttons: [
                        .destructive(Text("Sign Out"),action: {
                            didTapLogOut()
                        }),
                        .cancel()

                    ])
                }

        }
    }
}
