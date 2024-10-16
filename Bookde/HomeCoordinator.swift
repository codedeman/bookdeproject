//
//  HomeCoordinator.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    private let homeFactory: HomeFactory

    init(navigation: UINavigationController, homeFactory: HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }

    func start() {
        let controller = homeFactory.makeAuthenticate()
        controller.modalPresentationStyle = .fullScreen
        navigation.present(controller, animated: true)
    }
}
