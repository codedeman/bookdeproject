//
//  MessageListView.swift
//  
//
//  Created by Kevin on 11/9/23.
//

import SwiftUI
import CoreUI

public struct MessageListView: View {
    var users: [User] = []
    var loading: Bool
    @State private var selectedUser: User? = nil
    let didSelectUser: (User) -> ()

    public var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(users) { user in
                Button{
                    withAnimation(.linear(duration: 0.3)) {
                        didSelectUser(user)
                    }
                }label: {
                    VStack {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: user.profileUrl))
                                .frame(width: 40, height: 40)
                                .cornerRadius(64)
                                .foregroundColor(Color.blue).shimmering(active: loading)
                            VStack(alignment: .leading) {
                                Text(user.email)
                                    .font(.system(size: 16, weight: .bold)).shimmering(active: loading)
                                Text("Mesage sent to user")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray).shimmering(active: loading)
                            }
                            Spacer()
                            Text("22d")
                        }
                        Divider()
                            .padding(.vertical,8)
                }


                }

            }.padding(.horizontal)
        }
    }
}


