//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/13/23.
//

import SwiftUI

struct SearchNewFeedView: View {
    @State  var txtSearch: String
    var body: some View {
        HStack(alignment: .center) {
            Image("ic_search").frame(
                width: 30,
                height: 30
            )
            VStack(alignment: .leading) {
                TextField(
                    "Where to?",
                    text: self.$txtSearch
                ).font(.subheadline)
                    .frame(height: 50)
                Text("Any where add guest")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }

            Button(action: {
            }) {
                Image("defaultIcoLocation24")
            }.padding(.trailing,15)
        }.shadow(color: .white, radius: 20)
            .background(.white)
            .cornerRadius(20)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNewFeedView(txtSearch: "Bookde")
    }
}
