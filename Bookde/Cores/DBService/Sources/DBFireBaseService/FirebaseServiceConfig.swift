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

    func signInWithEmail(email: String, passworld: String) async -> Result<UserDTO, Error>
    func signUpWithEmail(email: String, passworld: String, imageProfile: Data?) async -> Result<UserDTO, Error>
    func fetchCurrentUser() async -> Result<DocumentDTO, Error>
    func fetchAllUsers() async -> Result<[DocumentDTO], Error>
    func signOut() async  -> Bool
    func sendMessage(toId: String, message: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func fetchMessage(toId: String) async -> Result<[MessageDTO], Error>
     func fetchMessage(toId: String, completion: @escaping (Result<[MessageDTO], Error>) -> Void)
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

//MARK: Send Message
    public func sendMessage(toId: String,
                            message: String,
                            completion: @escaping (Result<Bool, Error>
                            ) -> Void) {
        guard let fromId = Auth.auth().currentUser?.uid, !toId.isEmpty else {
            completion(.failure(FirbaseError.generic))
            return
        }

        let messageData = [
            "fromId": fromId,
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
                if let error = error {
                    completion(.failure(error))
                }
            }

        Firestore
            .firestore()
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document().setData(messageData) { error in
                if let error = error {
                    completion(.failure(error))
                }
                completion(.success(true))

            }
    }

    public func fetchCurrentUser() async -> Result<DocumentDTO, Error> {
        guard let uiid = Auth.auth().currentUser?.uid  else { return .failure(FirbaseError.generic) }

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
                "profileUrl": ""
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

        Firestore
            .firestore()
            .collection("messages")
            .document(uid)
            .setData(userData) { error in
                if let error = error {
                    print("error \(error)")
                }
                print("<==== message success ====>")
            }

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
        guard let userId = Auth.auth().currentUser?.uid else { return .failure(FirbaseError.generic) }

        do {
            let snapshot = try await Firestore.firestore()
                .collection("users")
                .getDocuments()

            snapshot.documents.forEach { document in
                let data = document.data()
                let documentDTO = DocumentDTO(dic: data)
                if documentDTO.uiid != userId {
                    users.append(documentDTO)
                }
            }
            return .success(users)
        } catch {
            return .failure(error)
        }

   }
 // MARK: Fetch Message Two People 
    public func fetchMessage(toId: String) async -> Result<[MessageDTO], Error> {
        guard let fromId = Auth.auth().currentUser?.uid  else { return .failure(FirbaseError.generic) }

        let query = Firestore.firestore()
            .collection("messages")
            .document(fromId)
            .collection(toId)

        do {
            let querySnapshot = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[MessageDTO], Error>) in
                var nillableContinuation: CheckedContinuation<[MessageDTO], Error>? = continuation

                _ = query.addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        nillableContinuation?.resume(throwing: error)
                        return
                    }

                    guard let querySnapshot = querySnapshot else {
                        nillableContinuation?.resume(throwing: AppError.genericError)
                        return
                    }

                    let messagesDTO = querySnapshot.documents.compactMap { document -> MessageDTO? in
                        guard let data = document.data() as? [String: Any] else { return nil }
                        let messageDto = MessageDTO(
                            json: data,
                            dococumentId: document.documentID
                        )
                        return messageDto
                    }
                    nillableContinuation?.resume(with: .success(messagesDTO))
                    nillableContinuation = nil
                }
            }

            return .success(querySnapshot)
        } catch {
            return .failure(error)
        }
    }

    public func fetchMessage(toId: String, completion: @escaping (Result<[MessageDTO], Error>) -> Void) {
        guard let fromId = Auth.auth().currentUser?.uid, !toId.isEmpty  else {
            completion(.failure(FirbaseError.generic))
            return
        }
        var messages: [MessageDTO] = []
        _ = Firestore.firestore()
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .addSnapshotListener { querySnapShot, error in
                if let error = error {
                    completion(.failure(error))
                }
                querySnapShot?.documents.forEach({ document in
                    let data = document.data()
                    let messageDto = MessageDTO(
                        json: data,
                        dococumentId: document.documentID
                    )
                    messages.append(messageDto)
                })
                completion(.success(messages))
            }

    }

    public init () {}

}
