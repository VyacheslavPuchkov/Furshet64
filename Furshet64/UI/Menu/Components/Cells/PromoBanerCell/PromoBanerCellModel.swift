//
//  PromoBanerCellModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit
import Combine

class PromoBanerCellModel: FCellViewModel {
    
    @Published var cellModels: [FCellViewModel] = []
    
    init() {
        super.init(cellIdentifier: "PromoBanerCell")
        getPromotionImage()
    }
    
    func getPromotionImage() {
        DatabaseService.shared.getImagePromotion { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let promotionImage):
                self.makeViewModels(for: promotionImage)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeViewModels(for promotionImage: [PromotionImage]) {
        promotionImage.forEach { cellModels.append(PromoBanerCollectionCellModel(image: UIImage(named: "productFoto") ?? UIImage(), imageName: $0.title))
        }
    }

    
}
