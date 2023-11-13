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
    public var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(users) { user in
                VStack {
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: user.profileUrl))
                            .frame(width: 30, height: 30)
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

                }.padding(.horizontal)
            }.padding(.horizontal)
        }
    }
}


