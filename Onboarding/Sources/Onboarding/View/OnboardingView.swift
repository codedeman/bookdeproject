//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/12/23.
//

import SwiftUI
import UIKit
import Home

public struct OnboardingView: View {
    @State var showSheetView = false
    @StateObject private var modelData = DBHome(landmarks:.init())

    public var body: some View {
        NavigationView {
            pages()
        }.sheet(isPresented: $showSheetView) {

        }.animation(.none)
    }
    
    public init(showSheetView: Bool = false) {
        self.showSheetView = showSheetView
    }
}
struct pages: View {
    @StateObject private var modelData = DBHome(landmarks:.init())
    var body: some View {
        VStack {
           TabView {
               ForEach(Data) { page in
                   GeometryReader { g in
                       VStack {
                           Image(page.image)
                               .resizable()
                               .scaledToFit()
                           Text(page.title)
                               .font(.title).bold()
                               .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 20)
                           Text(page.descrip)
                               .multilineTextAlignment(.center)
                               .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                       }
                       .opacity(Double(g.frame(in : . global).minX)/200+1)
                   }
               }
           }
           .edgesIgnoringSafeArea(.top)
           .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            NavigationLink(destination: HomeView().environmentObject(modelData)) {
                Text("Start")
                    .font(.headline)
                    .frame(width: 200, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(#colorLiteral(red: 0.9580881,
                                                    green: 0.10593573,
                                                    blue: 0.3403331637,
                                                    alpha: 1)))
                    .cornerRadius(10)
            }
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
