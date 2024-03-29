import CoreUI
import SwiftUI

public struct MessageListView: View {
    var users: [UserChat] = []
    var loading: Bool
    @State private var selectedUser: UserChat? = nil
    let didSelectUser: (UserChat) -> ()

    public var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(users) { user in
                Button(action: {
                    // Handle button tap here
                    didSelectUser(user) // Assuming this action is desired
                }) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 0) {
                            AsyncImage(url: URL(string: user.profileUrl))
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, maxHeight: 50)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                            VStack(alignment: .leading) {
                                Text(user.email)
                                    .font(.system(size: 16, weight: .bold))
                                Text("Message sent to user ")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                }
            }.frame(maxHeight: .infinity)
        }
    }
}
