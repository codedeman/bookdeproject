//
//  File.swift
//  
//
//  Created by Kevin on 9/28/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import DBCore

enum FirbaseError: Error {
    case generic
}
public protocol FireRepository {
    func signInWithEmail(email: String, passworld: String) async -> Result<UserDTO,Error>
    func signUpWithEmail(email: String, passworld: String) async -> Result<UserDTO,Error>
}

public extension FireRepository {
    func signInWithEmail(email: String, passworld: String) async -> Result<UserDTO,Error> {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: passworld)
            let userDTO = UserDTO.mapper(user: user)
            return  .success(userDTO)
        } catch {
            return .failure(error)
        }
    }

}

public final class ImplFireRepository: FireRepository {
    public func signUpWithEmail(email: String, passworld: String) async -> Result<UserDTO, Error> {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: passworld)
            let userDTO = UserDTO.mapper(user: user)
            return  .success(userDTO)
        } catch {
            return .failure(error)
        }

    }

    public func signInWithEmail<T>(email: String, passworld: String) async ->  Result<T,Error> where T : Decodable, T : Encodable {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: passworld)
            return  .success(user as! T)
        } catch {
            return .failure(error)
        }
    }

    public init () {}


}
