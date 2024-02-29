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
    @Published var count: Int
    var cost: Int
    var delegate: ChangeCountProduct
    
    init(id: String, product: Product, count: Int, cost: Int, delegate: ChangeCountProduct) {
        self.id = id
        self.product = product
        self.count = count
        self.cost = cost
        self.delegate = delegate
        super.init(cellIdentifier: "OrderTableCell")
    }
    
}
