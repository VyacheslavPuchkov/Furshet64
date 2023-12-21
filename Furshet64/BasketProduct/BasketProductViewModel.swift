//
//  BasketProductViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 16.12.2023.
//

import UIKit

class BasketProductViewModel: NSObject {
    
    // MARK: - Variable
    var orders: [OrderModel] = .init()
    
    var cost: Int {
        var sum = 0
        
        for order in orders {
            sum += order.cost
        }
        return sum
    }

    // MARK: - Init
    override init() {
        super.init()
    }
    
}
