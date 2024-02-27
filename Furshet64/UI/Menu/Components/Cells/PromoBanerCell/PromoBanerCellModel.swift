//
//  PromoBanerCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit

class PromoBanerCellModel: FCellViewModel {
    
    var cellModels: [FCellViewModel] = []
    
    init() {
        super.init(cellIdentifier: "PromoBanerCell")
        let imageName: [String] = ["banner1.jpg","banner2.jpg","banner3.jpg"]
        imageName.forEach { cellModels.append(PromoBanerCollectionCellModel(image: UIImage(named: "productFoto") ?? UIImage(), imageName: $0))}
    }

    
}
