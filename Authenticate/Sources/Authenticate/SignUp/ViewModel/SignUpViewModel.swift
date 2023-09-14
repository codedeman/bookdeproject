//
//  File.swift
//  
//
//  Created by Kevin on 8/21/23.
//

import Foundation
//import Fire
final class SignUpViewModel: ObservableObject {

    private var useCase: SignUpUseCase!

    init(useCase: SignUpUseCase) {
        self.useCase = useCase
    }

    struct Input {

    }

}
