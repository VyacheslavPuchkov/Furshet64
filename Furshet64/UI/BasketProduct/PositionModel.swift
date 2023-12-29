//
//  PositionModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 29.12.2023.
//

import Foundation

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
        repres["cost"] = self.cost
        return repres
    }
    
}
