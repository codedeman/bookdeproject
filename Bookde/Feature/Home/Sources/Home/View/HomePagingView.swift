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
        VStack(spacing: 10) {
            NavigationLink(destination: AppartmentView(rentingData: landmark.subList.first!)) {
                VStack(alignment: .leading) {
                    HomePaging(landmark: landmark)
                        .padding([.leading,
                                  .trailing],15)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .foregroundColor(.black)
                            .lineLimit(0)
                            .font(.headline)
                        Text(landmark.description)
                            .foregroundColor(.black)
                            .font(.body)
                        Text(landmark.state)
                            .foregroundColor(.black)
                            .font(.title3)
                    }

                }.background()
                    .foregroundColor(.red)

            }
        }
    }
}

struct HomePaging: View {

    var landmark: HomeModel
    var body: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(landmark.subList)  { sub in
                    sub.image
                        .renderingMode(.original)
                        .resizable().aspectRatio(
                            contentMode: .fill
                        ).padding(.all,5)
                }.onAppear() {

                }
            }
        }.padding([.leading,.trailing],0)
    }
}



struct NewFeedView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedView(landmark: DBHome(landmarks: .init()).landmarks[0])
    }
}
