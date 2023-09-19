//
//  AppDelegate.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//

import SwiftUI
import Home
import DBCore
import Authenticate
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator!
    var appFactory: AppFactory!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App Did Launch!")
        FirebaseApp.configure()
        let navigation = UINavigationController()
        appFactory = AppFactoryImp()
        window = UIWindow()
        appCoordinator = AppCoordinator(navigation: navigation, appFactory: appFactory, window: window)
        appCoordinator.start()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

}
