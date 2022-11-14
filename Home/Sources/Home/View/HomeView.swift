//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/13/23.
//

import SwiftUI
//
public struct HomeView: View {
    @EnvironmentObject var modelData: DBHome

    public init() {

    }

    public var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                SearchNewFeedView(txtSearch: "")
                    .padding([.all],20)
                    .shadow(radius: 0.5)
                    ForEach(modelData.landmarks) { object in
                        HomeFeedView(landmark: object)

                        NavigationLink(destination:  AppartmentView(rentingData: object.subList.first!)) {
    //
                        }.buttonStyle(.plain).frame(width: 0,height: 0).hidden()

                    }
//                    ForEach(modelData.users) { user in
//                        HStack(alignment:.top) {
//                            Text("\(user.email)")
//                        }
//                    }
//                }
            }.onAppear {
//                modelData.getUsers()
            }

        }.navigationTitle("OMG")

    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
