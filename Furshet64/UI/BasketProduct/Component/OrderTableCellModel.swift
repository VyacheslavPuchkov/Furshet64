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
    var cost: Int {
        return product.price * self.count
    }
    
    init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
        super.init(cellIdentifier: "OrderTableCell")
    }
    
}
