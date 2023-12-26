//
//  BasketProductManager.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 16.12.2023.
//

import UIKit
import Combine

class BasketProductManager: NSObject {
    
    // MARK: - Static constant
    static let shared = BasketProductManager()
    
    // MARK: - Variable
    @Published var orders: [OrderModel] = []
    
    var cost: Int {
        var sum = 0
        
        for order in orders {
            sum += order.cost
        }
        return sum
        
    }
    
    // MARK: - Func
    func addOrder(_ order: OrderModel) {
        self.orders.append(order)
    }
    
}
