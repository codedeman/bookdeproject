//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/13/23.
//

import SwiftUI

struct HomeFeedView: View {
    var landmark: HomeModel
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            //            PageView(listRent: landmark.subList).padding([.leading,.trailing],15)
            HStack(spacing: 0) {
                Image("defaultIcoLocation24")
                    .aspectRatio(contentMode: .fit)
                Text(landmark.park)
                    .foregroundColor(.gray)
            }.padding(.leading,15)
        }.shadow(
            color: .gray,
            radius: 30
        ).background(.white)
    }
}

struct HomePaging: View {

    var landmark: HomeModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(landmark.subList)  { sub in
                    sub.image
                        .renderingMode(.original)
                        .resizable().aspectRatio(
                            contentMode: .fit
                        ).padding(.all,5)
                }.onAppear() {

                }
            }
        }.padding([.leading,.trailing],15)
    }
}



struct NewFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView(landmark: DBHome(landmarks: .init()).landmarks[0])
    }
}
