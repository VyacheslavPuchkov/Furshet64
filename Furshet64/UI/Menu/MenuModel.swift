//
//  MenuModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import FirebaseFirestore

struct MenuType: Identifiable {
    
    var id: String
    var title: String
    var selected: Bool = false
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        
        return repres
    }
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        
        self.id = id
        self.title = title
    }
    
}
