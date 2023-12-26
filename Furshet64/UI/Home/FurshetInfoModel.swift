//
//  FurshetInfoModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.10.2023.
//

import Foundation
import FirebaseFirestore

struct FurshetInfo {
    
    var imageName: String
    var url: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["imageName"] = self.imageName
        repres["url"] = self.url
        return repres
    }
    
    init(imageName: String, url: String) {
        self.imageName = imageName
        self.url = url
    }
    
    init? (doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let imageName = data["imageName"] as? String else { return nil }
        guard let url = data["url"] as? String else { return nil }
        
        self.imageName = imageName
        self.url = url
    }
    
}
