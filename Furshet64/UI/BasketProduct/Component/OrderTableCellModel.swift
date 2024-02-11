//
//  OrderCollectionVewCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.02.2024.
//

import Foundation

class OrderTableCellModel: FCellViewModel {
    
    var id: String
    var product: Product
    var count: Int
    var cost: Int
    
        init(id: String, product: Product, count: Int, cost: Int) {
        self.id = id
        self.product = product
        self.count = count
        self.cost = cost
        super.init(cellIdentifier: "OrderTableCell")
    }
    
}
