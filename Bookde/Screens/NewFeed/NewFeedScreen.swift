//
//  NewFeedScreen.swift
//  Bookde
//
//  Created by Kevin on 11/14/22.
//

import SwiftUI

struct NewFeedScreen: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                SearchNewFeedView(txtSearch: "")
                    .padding([.all],20)
                    .shadow(radius: 0.5)
                    ForEach(modelData.landmarks) { object in
                        NewFeedView(landmark: object)
                        
                        NavigationLink(destination: DetailRentScreen(rentingData: object.subList.first!)) {
    //
                        }.buttonStyle(.plain).frame(width: 0,height: 0).hidden()

                    }
                    ForEach(modelData.users) { user in
                        HStack(alignment:.top) {
                            Text("\(user.email)")
                        }
                    }
//                }
            }.onAppear {
                modelData.getUsers()
            }
            
        }.navigationTitle("OMG")
        
    }
}

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

struct NewFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewFeedScreen().environmentObject(ModelData())
    }
}


