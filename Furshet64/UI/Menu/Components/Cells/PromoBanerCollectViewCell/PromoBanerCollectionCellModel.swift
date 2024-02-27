//
//  PromoBanerCollectVeiwCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit

class PromoBanerCollectionCellModel: FCellViewModel {
    
    var image: UIImage
    var imageName: String
    
    init(image: UIImage, imageName: String) {
        self.image = image
        self.imageName = imageName
        super.init(cellIdentifier: "PromoBanerCollectionCell")
    }
    
}

