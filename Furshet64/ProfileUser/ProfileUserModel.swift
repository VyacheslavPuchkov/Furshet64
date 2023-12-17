//
//  ProfileUserModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.10.2023.
//

import Foundation

struct ProfileUser: Identifiable {
    
    var id: String
    var name: String
    var phone: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        return repres
    }
    
}
