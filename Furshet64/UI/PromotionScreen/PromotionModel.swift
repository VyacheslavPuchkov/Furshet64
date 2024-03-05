//
//  PromotionModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 04.03.2024.
//

import Foundation
import FirebaseFirestore

struct Promotion: Identifiable {
    
    var id: String
    var title: String
    var decription: String
    var validity: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["decription"] = self.decription
        repres["validity"] = self.validity
        return repres
    }
    
    init(id: String, title: String, decription: String, validity: String) {
        self.id = id
        self.title = title
        self.decription = decription
        self.validity = validity
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let decription = data["decription"] as? String else { return nil }
        guard let validity = data["validity"] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.decription = decription
        self.validity = validity
    }
    
}

