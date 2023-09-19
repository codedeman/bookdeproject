//
//  File.swift
//  
//
//  Created by Kevin on 8/21/23.
//

import Foundation

public final class SignUpViewModel: ObservableObject {

    private var useCase: SignUpUseCase!

    public init(useCase: SignUpUseCase) {
        self.useCase = useCase
    }

    struct Input {

    }

    func signIn(_ email: String,
                passworld: String
    ) async {
        await useCase.signUp(email: email, passworld: passworld)
    }
}
