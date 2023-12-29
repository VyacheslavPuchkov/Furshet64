//
//  OrderModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import Foundation
import FirebaseFirestore

struct OrderModel: Identifiable {

    var id: String
    var posiotions: [Position]
    var userID: String
    var date: Date
    var cost: Int

    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["date"] = self.date
        repres["userID"] = self.userID
        repres["cost"] = self.cost

        return repres
    }
    
}
