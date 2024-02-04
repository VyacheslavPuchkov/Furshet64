//
//  TypeMenuModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.12.2023.
//

//import Foundation
//import FirebaseFirestore
//
//struct MenuType: Identifiable {
//    
//    var id: String
//    var title: String
//    var selected: Bool = false
//    
//    var representation: [String: Any] {
//        var repres = [String: Any]()
//        repres["id"] = self.id
//        repres["title"] = self.title
//        
//        return repres
//    }
//    
//    init(id: String, title: String) {
//        self.id = id
//        self.title = title
//    }
//    
//    init? (doc: QueryDocumentSnapshot) {
//        let data = doc.data()
//        
//        guard let id = data["id"] as? String else { return nil }
//        guard let title = data["title"] as? String else { return nil }
//        
//        self.id = id
//        self.title = title
//    }
//    
//}
//
//extension MenuTypeProduct {
//    
//    var typeProductValue: TypeProduct {
//        get {
//            if title == "Холодные закуски из сыра и овощей" {
//                return .snackWegetablesCheese
//            } else if title == "Холодные закуски из морепродуктов" {
//                return .snackSeafood
//            } else if title == "Канапе, брускеты, закуски мясные" {
//                return .snackMeat
//            } else {
//                return .all
//            }
//        }
//    }
//    
//}



