//
//  PromoBanerCollectVeiwCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit

class PromoBanerCollectionCellModel: FCellViewModel {
    var image: UIImage
    init(image: UIImage) {
        self.image = image
        super.init(cellIdentifier: "PromoBanerCollectionCell")
    }
}

