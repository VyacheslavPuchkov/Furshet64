//
//  PositionModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 29.12.2023.
//

import Foundation
import FirebaseFirestore

struct Position: Identifiable {
    
    var id: String
    var product: Product
    var count: Int
    var cost: Int {
        return product.price * self.count
    }
    
    var representation: [String: Any] {
        
        var repres = [String: Any]()
        repres["id"] = id
        repres["title"] = product.title
        repres["price"] = product.price
        repres["count"] = count
        repres["cost"] = cost
        return repres
    }
    
    init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let count = data["count"] as? Int else { return nil }
        
        let product: Product = .init(id: "", title: title, price: price, typeProduct: "")
        
        self.id = id
        self.product = product
        self.count = count
    }
    
}
