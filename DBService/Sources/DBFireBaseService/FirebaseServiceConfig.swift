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
import FirebaseFirestore

enum FirbaseError: Error {
    case generic
}
public protocol FireRepository {
    func signInWithEmail(email: String, passworld: String) async -> Result<UserDTO,Error>
    func signUpWithEmail(email: String, passworld: String, imageProfile: Data?) async -> Result<UserDTO,Error>

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

    public func signUpWithEmail(
        email: String,
        passworld: String,
        imageProfile: Data? = nil
    ) async -> Result<UserDTO, Error> {

        do {
            let user = try await Auth.auth().createUser(withEmail: email, password: passworld)
            let userDTO = UserDTO.mapper(user: user)
            storeUseInformation(uid: userDTO.uid,
                                email: userDTO.email ?? "",
                                imageData: imageProfile)
            return  .success(userDTO)
        } catch {
            return .failure(error)
        }

    }

    private func storeUseInformation(
        uid: String,
        email: String,
        imageData: Data?
    ) {
        var userData: [String: Any] = [:]
        guard  let data = imageData  else { return }
           let str = String(decoding: data, as: UTF8.self)
            userData = [
                "uid": uid,
                "email": email,
                "profileUrl": str
            ]


        Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    print("error \(error)")
                }
                print("<==== scucess ====>")
            }

        let ref = Storage
            .storage()
            .reference(withPath: uid)

        ref.putData(data) { file, error in
            if let error = error {
                print(" upload image \(error)")
            }
        }

   }

    public init () {}


}
