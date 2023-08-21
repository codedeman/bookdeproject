//
//  HomeDIContainer.swift
//  
//
//  Created by Kevin on 8/22/23.
//

import UIKit
import DBService

public class HomeDIContainer {

    var configuration: Configuration
    var diContainer: Dependencies

    public init(configuration: Configuration, diContainer: Dependencies) {
        self.configuration = configuration
        self.diContainer = diContainer
    }

    public struct Configuration {
        var service: DBServiceProtocol
        var useCase: HomeUseCase
    }

    public struct Dependencies {


    }
}
