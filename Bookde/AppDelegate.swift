//
//  AppDelegate.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//

import SwiftUI
import Home
import DBCore


class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator!
    var appFactory: AppFactory!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App Did Launch!")
        let navigation = UINavigationController()
        appFactory = AppFactoryImp()
        window = UIWindow()
        appCoordinator = AppCoordinator(navigation: navigation, appFactory: appFactory, window: window)
        appCoordinator.start()
        FirebaseApp.configure()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

}
