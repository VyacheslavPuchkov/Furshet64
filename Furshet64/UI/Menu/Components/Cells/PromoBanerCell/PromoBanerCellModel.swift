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
        
//        let images: [UIImage?] = [UIImage(named: "banner"), UIImage(named: "banner"), UIImage(named: "banner")]
//        images.forEach { cellModels.append(PromoBanerCollectionCellModel(image: $0 ?? UIImage())) }
        
    }
}
