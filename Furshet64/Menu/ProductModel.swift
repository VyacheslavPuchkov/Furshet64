//
//  ProductModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

import Foundation
import FirebaseFirestore

struct Product: Identifiable {
   
    var id: String
    var title: String
    var imageUrl: String
    var price: Int
    var typeProduct: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["imageUrl"] = self.imageUrl
        repres["price"] = self.price
        repres["typeProduct"] = self.typeProduct
        
        return repres
    }
    
    init(id: String, title: String, imageUrl: String, price: Int, typeProduct: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.typeProduct = typeProduct
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let imageUrl = data["imageUrl"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let typeProduct = data["typeProduct"] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.typeProduct = typeProduct
    }
    
}
