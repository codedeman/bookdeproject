//
//  SignUpUseCase.swift
//  
//
//  Created by Kevin on 8/22/23.
//

import UIKit
import FileProvider

protocol SignUpUseCase {
    func signUp(email: String, passworld: String) async -> Bool

}

final class SignUpUseCaseImpl: SignUpUseCase {

    func signUp(
        email: String,
        passworld: String
    ) async -> Bool {
        return true
    }
}
