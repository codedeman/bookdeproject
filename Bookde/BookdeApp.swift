//
//  BookdeApp.swift
//  Bookde
//
//  Created by Kevin on 11/14/22.
//

import SwiftUI
import Onboarding
@main
struct BookdeApp: App {
    var body: some Scene {
        WindowGroup {
           OnboardingView()
//            NewFeedScreen().environmentObject(modelData)
        }
    }
}
