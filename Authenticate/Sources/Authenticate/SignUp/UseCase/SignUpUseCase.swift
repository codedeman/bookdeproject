//
//  SignUpUseCase.swift
//  
//
//  Created by Kevin on 8/22/23.
//

import UIKit
import FirebaseAuth


public protocol SignUpUseCase {
    func signUp(email: String, passworld: String) async -> Bool
}

public final class SignUpUseCaseImpl: SignUpUseCase {

    public init() {
        
    }
    public func signUp(
        email: String,
        passworld: String
    ) async -> Bool {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: passworld)
            print("---> user \(user.user.email)")
        } catch {
            return false
        }
        return true
    }
}
