//
//  ProductModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

import Foundation
import FirebaseFirestore

//enum TypeProduct: String {
//   
//    case all
//    case snackWegetablesCheese
//    case snackSeafood
//    case snackMeat
//    
//}

struct Product: Identifiable {
   
    var id: String
    var title: String
    var price: Int
    var typeProduct: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["typeProduct"] = self.typeProduct
        
        return repres
    }
    
    init(id: String, title: String, price: Int, typeProduct: String) {
        self.id = id
        self.title = title
        self.price = price
        self.typeProduct = typeProduct
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let typeProduct = data["typeProduct"] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.price = price
        self.typeProduct = typeProduct
    }
    
}

//
//extension Product {
//
//    var typeProductValue: TypeProduct {
//        get {
//            if typeProduct == "Холодные закуски из сыра и овощей" {
//                return .snackWegetablesCheese
//            } else if typeProduct == "Холодные закуски из морепродуктов" {
//                return .snackSeafood
//            } else if typeProduct == "Канапе, брускеты, закуски мясные" {
//                return .snackMeat
//            } else {
//                return .all
//            }
//        }
//    }
    
//}
