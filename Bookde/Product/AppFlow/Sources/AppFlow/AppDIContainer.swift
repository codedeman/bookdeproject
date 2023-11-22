//
//  AppDIContainer.swift
//  
//
//  Created by Kevin on 10/24/23.
//
//import Authenticate

import Authenticate
import Home
import DBService
import Combine
import MessageCenter

public final class AppDIContainer {

    var dependencies: Dependencies

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies

    }

    public struct Dependencies {
        var authUseCase: AuthenticateUseCase
        var mesageUseCase: MessageUseCase
        public init(authUseCase: AuthenticateUseCase, mesageUseCase: MessageUseCase) {
            self.authUseCase = authUseCase
            self.mesageUseCase = mesageUseCase
        }
    }

}

extension AppDIContainer {

    func builderConfig() -> AppDIContainer {
        return AppDIContainer(dependencies: .init(
            authUseCase: ImplAuthenticateUseCase(),
            mesageUseCase: ImplMessageUseCase())
        )
    }
}

