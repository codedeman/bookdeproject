import CoreUI
import SwiftUI

public struct MessageListView: View {
    var users: [UserChat] = []
    var loading: Bool
    @State private var selectedUser: UserChat? = nil
    let didSelectUser: (UserChat) -> ()

    public var body: some View {
        VStack {
            
        }
//        ScrollView(showsIndicators: false) {
//            ForEach(users) { user in
//                Button(action: {
//                    withAnimation(.linear(duration: 0.3)) {
//                        didSelectUser(user)
//                    }
//                }) {
//                    VStack {
//                        HStack(spacing: 16) {
//                            AsyncImage(url: URL(string: user.profileUrl))
//                                .cornerRadius(64)
//                                .foregroundColor(Color.blue).shimmering(active: loading)
//                            VStack(alignment: .leading) {
//                                Text(user.email)
//                                    .font(.system(size: 16, weight: .bold)).shimmering(active: loading)
//                                Text("Message sent to user")
//                                    .font(.system(size: 12))
//                                    .foregroundColor(.gray).shimmering(active: loading)
//                            }
//                            Spacer()
//                            Text("22d")
//                        }
//                        Divider()
//                            .padding(.vertical)
//                    }
//                }
//
//            }.padding(.horizontal)
//        }
    }
}
