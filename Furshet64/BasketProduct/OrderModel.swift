//
//  OrderModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import Foundation
import FirebaseFirestore

struct OrderModel: Identifiable {
    
    var id: String
    var product: Product
    var count: Int
    
    var cost: Int {
        return product.price * self.count
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["product"] = self.product
        repres["count"] = self.count
        
        return repres
    }
    
    init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let product = data["product"] as? Product else { return nil }
        guard let count = data["count"] as? Int else { return nil }
        
        self.id = id
        self.product = product
        self.count = count
    }
    
}

