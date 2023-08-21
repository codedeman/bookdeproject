//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/16/23.
//

import SwiftUI
import Authenticate

public struct TabBar: View {
    @State private var selection = 1

    public init() {
        UITabBar.appearance().backgroundColor = .white
    }
    public var body: some View {
        TabView(selection: $selection) {

//        HomeView(viewModel: )
////            HomeView(viewModel: <#HomeViewModel#>)
//                .environmentObject(modelData)
//                .tabItem {
//                VStack {
//                    Image(systemName: "house.fill")
//                    Text("Home")
//                }
//
//            }.tag(1)


            Text("Login").tabItem {
                VStack {
                    SignUpView().tabItem {
                        Image(systemName: "person.fill")
                                        Text("Profile")
                    }
                }

            }.tag(3)
        }
        .accentColor(.black)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
