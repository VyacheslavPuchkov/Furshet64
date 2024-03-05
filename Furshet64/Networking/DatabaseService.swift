//
//  DatabaseService.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    
    static let shared = DatabaseService(); private init () { }
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference { db.collection("users") }
    private var furshetInfoRef: CollectionReference { db.collection("furshetInfo") }
    private var typeProductRef: CollectionReference { db.collection("typeProduct") }
    private var productRef: CollectionReference { db.collection("menu") }
    private var orderRef: CollectionReference { db.collection("orders") }
    private var promotionRef: CollectionReference { db.collection("promotion")}
    private var promotionImageRef: CollectionReference { db.collection("promotionImage") }
    
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
                var furshetInfos: [FurshetInfo] = []
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
    
    func getTypeProduct(completion: @escaping(Result<[MenuType], Error>) -> ()){
        typeProductRef.getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var typeProducts: [MenuType] = []
                for doc in docSnapshot.documents {
                    if let typeProduct = MenuType(doc: doc) {
                        typeProducts.append(typeProduct)
                    }
                }
                completion(.success(typeProducts))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getProduct(productType: String, completion: @escaping(Result<[Product], Error>) -> ()){
        let predicate = NSPredicate(format: "typeProduct == %@", productType)
        productRef.filter(using: predicate).getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var products: [Product] = []
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
    
    func setPositions(to orderId: String, positions: [Position], completion: @escaping(Result<[Position], Error>) -> ()) {
        let positionsRef = orderRef.document(orderId).collection("positions")
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
    }
    
    func setOrder(order: OrderModel, completion: @escaping(Result<OrderModel, Error>) -> ()) {
        orderRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id, positions: order.posiotions) { result in
                    switch result {
                    case .success(_):
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getOrders(for user: User, completion: @escaping(Result<[OrderModel], Error>) -> ()) {
        let predicate = NSPredicate(format: "userID == %@", user.uid)
        orderRef.filter(using: predicate).getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var orders: [OrderModel] = []
                for doc in docSnapshot.documents {
                    if let order = OrderModel(doc: doc) {
                        orders.append(order)
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getPositions(for orderId: String, completion: @escaping(Result<[Position], Error>) -> ()) {
        let positionsRef = orderRef.document(orderId).collection("positions")
        positionsRef.getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var positions: [Position] = []
                for doc in docSnapshot.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
   func getPromotion(imageId: String, completion: @escaping(Result<Promotion, Error>) -> ()) {
       let predicate = NSPredicate(format: "id == &@", imageId)
       promotionRef.filter(using: predicate).getDocuments { docSnapshot, error in
           if let docSnapshot = docSnapshot {
               for doc in docSnapshot.documents {
                   if let promotion = Promotion(doc: doc) {
                       completion(.success(promotion))
                   } else if let error = error {
                       completion(.failure(error))
                   }
               }
           }
       }
    }
    
    func getImagePromotion(completion: @escaping(Result<[PromotionImage], Error>) -> ()) {
        promotionImageRef.getDocuments { docSnapshot, error in
            if let docSnapshot = docSnapshot {
                var promotionImages: [PromotionImage] = []
                for doc in docSnapshot.documents {
                    if let promotionImage = PromotionImage(doc: doc) {
                        promotionImages.append(promotionImage)
                    }
                }
                completion(.success(promotionImages))
            } else if let error {
                completion(.failure(error))
            }
        }
    }
    
}
