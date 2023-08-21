//
//  HomeFactory.swift
//  Bookde
//
//  Created by Kevin on 8/16/23.
//

import Foundation
import UIKit
import Home
import DBService
import SwiftUI

protocol HomeFactory {
    func makeModule() -> UIViewController
}



public struct HomeFactoryImp: HomeFactory {
    @MainActor
    func makeModule() -> UIViewController {
        let serviceBuilder = ServiceBuilder.buildAPIService()
        let db = DBHomeRespositoryImpl(apiService: serviceBuilder.dbClientService)
        let homeUseCase = HomeUseCaseImpl(repository: db)
        let homeViewModel = HomeViewModel(useCase: homeUseCase)
        return UIHostingController(rootView: HomeView(viewModel: homeViewModel))
    }

}


