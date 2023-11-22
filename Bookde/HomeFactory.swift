//
//  HomeFactory.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//

import Foundation
import UIKit
import DBService
import SwiftUI
import AppFlow
protocol HomeFactory {
    func makeAuthenticate() -> UIViewController
}

public struct HomeFactoryImp: HomeFactory {
    @MainActor

    func makeAuthenticate() -> UIViewController {
        let autView =  AppView(flow: AppStateManager())
        return UIHostingController(rootView: autView)

    }
}


