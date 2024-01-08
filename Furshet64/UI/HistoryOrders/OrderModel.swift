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
        repres["id"] = id
        repres["date"] = Timestamp(date: date)
        repres["userID"] = userID
        repres["cost"] = cost
        return repres
    }
    
    init(id: String, positions: [Position], userID: String, date: Date, cost: Int) {
        self.id = id
        self.posiotions = positions
        self.userID = userID
        self.date = date
        self.cost = cost
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let date = data["date"] as? Timestamp else { return nil }
        guard let userID = data["userID"] as? String else { return nil }
        guard let cost = data["cost"] as? Int else { return nil }
        let positions: [Position] = []
        
        self.id = id
        self.date = date.dateValue()
        self.userID = userID
        self.cost = cost
        self.posiotions = positions
    }
    
}

