//
//  ContentView.swift
//  Bookde
//
//  Created by Kevin on 11/14/22.
//

import SwiftUI

struct ContentView: View {
        // MARK: - Propertiers
        @StateObject private var modelData = ModelData()
        @State private var selection: Tab = .featured

            enum Tab {
                case featured
                case list
            }

            // MARK: - View
            var body: some View {
                TabView(selection: $selection) {
                    NewFeedScreen().environmentObject(modelData).tabItem {
                        Label("Featured", systemImage: "star")
                    }.tag(Tab.featured)
                
                    
                }
            }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
        
    }
}
