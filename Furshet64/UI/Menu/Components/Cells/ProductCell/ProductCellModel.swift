//
//  ProductCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit

class ProductCellModel: FCellViewModel {
    var image: UIImage?
    var title: String
    var compound: String
    var price: Int
    var id: String
    @Published var count: Int = 1
    var typeProduct: String
    var weight: String
    var delegate: ProductToBasketDelegate
    
    init(image: UIImage?, name: String, compound: String, price: Int, id: String, count: Int, typeProduct: String, weight: String, delegate: ProductToBasketDelegate) {
        self.image = image
        self.title = name
        self.compound = compound
        self.price = price
        self.id = id
        self.count = count
        self.typeProduct = typeProduct
        self.weight = weight
        self.delegate = delegate
        super.init(cellIdentifier: "ProductCell")
    }
    
    func addProduct() {
        count += 1
    }
    
    func deleteProduct() {
        if count > 1 {
            count -= 1
        }
    }
    
}
