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
    func fetchCurrentUser() async -> Result<DocumentDTO, Error>
    func fetchAllUsers() async -> Result<[DocumentDTO], Error>
    func signOut() async  -> Bool
    func sendMessage(toId: String, message: String)
     func fetchMessage(toId: String) async
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


    public func fetchCurrentUser() async -> Result<DocumentDTO, Error> {
        let uiid = Auth.auth().currentUser?.uid ?? ""

        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .document(uiid)
                .getDocument()

            guard let data = snapshot.data() else {
                throw AppError.genericError 
            }

            let document = DocumentDTO(dic: data)
            return .success(document)
        } catch {
            return .failure(error)
        }
    }


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
//        guard  let data = imageData  else { return }
//           let str = String(decoding: data, as: UTF8.self)
            userData = [
                "uid": uid,
                "email": email,
                "profileUrl": "https://firebasestorage.googleapis.com/v0/b/bookdeuiproject.appspot.com/o/6FA2236B-B62D-4E50-9855-83DA85ED3FBB.JPG?alt=media&token=5b98ac62-26cc-45f6-ad0d-82e962ead322&_gl=1*1824x0w*_ga*NjI4MDA1MDAuMTY5ODQ3OTY3MQ..*_ga_CW55HF8NVT*MTY5OTI2NDUzNC45LjEuMTY5OTI2NDYxNy40My4wLjA."
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

//        let ref = Storage
//            .storage()
//            .reference(withPath: uid)
//
//        ref.putData(data) { file, error in
//            if let error = error {
//                print(" upload image \(error)")
//            }
//        }

   }

    public func signOut() async -> Bool {
        do {
            try  Auth.auth().signOut()
            return true
        } catch {
            print("Error signing out: \(error)")
            return false
        }
    }

    public func fetchAllUsers() async -> Result<[DocumentDTO], Error> {
        var users: [DocumentDTO] = []
        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .getDocuments()

            snapshot.documents.forEach { document in
                let data = document.data()
                let documentDTO = DocumentDTO(dic: data)
                users.append(documentDTO)
            }
            return .success(users)
        } catch {
            return .failure(error)
        }

   }

    public func sendMessage(toId: String, message: String) {
        let fromId = Auth.auth().currentUser?.uid ?? ""

        let messageData = ["fromId": fromId,
                           "toId": toId,
                           "text" : message,
                           "timesstamp": Timestamp()
        ] as [String : Any]

        Firestore
            .firestore()
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document().setData(messageData) { error in
                if error != nil {
                    print("error")
                }
            }

        Firestore
            .firestore()
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document().setData(messageData) { error in
                if error != nil {
                    print("error")
                }
                print("success fully save message")
            }
    }

    public func fetchMessage(toId: String) async {
        let fromId = Auth.auth().currentUser?.uid ?? ""
        print("🔴 fromid \(fromId) , toId: \(toId)")
        do {
           Firestore
                .firestore()
                .collection("messages")
                .document(fromId)
                .collection(toId)
                .document().getDocument { snapshot, error in
                    guard  let dic  = snapshot?.data() as? [String: Any] else { return }
                    print("🔴", dic)
                }
        }

    }

    public init () {}


}
