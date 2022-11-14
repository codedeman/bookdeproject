//
//  PageView.swift
//  Bookde
//
//  Created by Kevin on 11/15/22.
//

import SwiftUI

struct PageView: View {
    var listRent: [ListRenting] = []
    var body: some View {
        TabView {
            ForEach(0..<listRent.count) { i in
                ZStack() {
                    listRent[i].image.resizable().aspectRatio(contentMode: .fill).foregroundColor(.white)
                    
                    NavigationLink(destination: DetailRentScreen(rentingData: listRent[i])) {
                        DetailRentScreen(rentingData: listRent[i])
                    }.buttonStyle(.plain).frame(width: 0,height: 0).hidden()

                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            }
            .padding(.all, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .tabViewStyle(PageTabViewStyle())
    }
}
