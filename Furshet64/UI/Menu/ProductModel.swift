//
//  ProductModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import FirebaseFirestore

struct Product: Identifiable {
   
    var id: String
    var title: String
    var price: Int
    var typeProduct: String
    var weight: String
    var compound: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["typeProduct"] = self.typeProduct
        repres["weight"] = self.weight
        repres["compound"] = self.compound
        
        return repres
    }
    
    init(id: String, title: String, price: Int, typeProduct: String, weight: String, compound: String) {
        self.id = id
        self.title = title
        self.price = price
        self.typeProduct = typeProduct
        self.weight = weight
        self.compound = compound
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let typeProduct = data["typeProduct"] as? String else { return nil }
        guard let weight = data["weight"] as? String else { return nil }
        guard let compound = data["compound"] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.price = price
        self.typeProduct = typeProduct
        self.weight = weight
        self.compound = compound
    }
    
}
