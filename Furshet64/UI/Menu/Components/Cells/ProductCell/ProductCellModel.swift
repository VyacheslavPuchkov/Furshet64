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
    var name: String
    var compound: String
    var price: Int
    var id: String
    var count: Int
    
    init(image: UIImage?, name: String, compound: String, price: Int, id: String, count: Int) {
        self.image = image
        self.name = name
        self.compound = compound
        self.price = price
        self.id = id
        self.count = count
        super.init(cellIdentifier: "ProductCell")
    }

}
