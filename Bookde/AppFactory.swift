//
//  AppFactory.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//

import Foundation
import UIKit

protocol AppFactory {
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator
}

struct AppFactoryImp: AppFactory {

    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let homeFactoryImpl = HomeFactoryImp()
        let homeCoordinator = HomeCoordinator(
            navigation: navigation,
            homeFactory: homeFactoryImpl
        )
        return homeCoordinator
    }
}
