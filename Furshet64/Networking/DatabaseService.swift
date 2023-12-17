//
//  DatabaseService.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.11.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService(); private init () { }
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference { db.collection("users") }
    private var furshetInfoRef: CollectionReference { db.collection("furshetInfo") }
    private var typeProductRef: CollectionReference { db.collection("typeProduct") }
    private var productRef: CollectionReference { db.collection("menu") }
    
    func setProfile(user: ProfileUser, completion: @escaping (Result<ProfileUser, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(completion: @escaping (Result<ProfileUser, Error>) -> ()) {
        usersRef.document(AuthService.shared.currentUser?.uid ?? "").getDocument { docSnapshot, error in
            guard let snap = docSnapshot else { return }
            guard let data = snap.data() else { return }
            guard let userId = data["id"] as? String else { return }
            guard let userName = data["name"] as? String else { return }
            guard let userPhone = data["phone"] as? String else { return }
            
            let user = ProfileUser(id: userId, name: userName, phone: userPhone)
            
            completion(.success(user))
        }
    }
    
    func getFurshetInfo(completion: @escaping(Result<[FurshetInfo], Error>) -> ()) {
        furshetInfoRef.getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var furshetInfos = [FurshetInfo]()
                for doc in docSnapshot.documents {
                    if let furshetInfo = FurshetInfo(doc: doc) {
                        furshetInfos.append(furshetInfo)
                    }
                }
                completion(.success(furshetInfos))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getTypeProduct(completion: @escaping(Result<[MenuTypeProduct], Error>) -> ()){
        typeProductRef.getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var typeProducts = [MenuTypeProduct]()
                for doc in docSnapshot.documents {
                    if let typeProduct = MenuTypeProduct(doc: doc) {
                        typeProducts.append(typeProduct)
                    }
                }
                completion(.success(typeProducts))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getProduct(completion: @escaping(Result<[Product], Error>) -> ()){
        productRef.getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var products = [Product]()
                for doc in docSnapshot.documents {
                    if let product = Product(doc: doc) {
                        products.append(product)
                    }
                }
                completion(.success(products))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
}

