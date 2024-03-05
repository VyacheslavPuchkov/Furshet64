//
//  PromotionViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 04.03.2024.
//

import UIKit
import Combine

class PromotionViewModel: NSObject {
    
    // MARK: - Combine
    var promotionDataSourse = CurrentValueSubject<Promotion, Never>(.init(id: "", title: "", decription: "", validity: ""))
    
    var imageId: String
    
    init(imageId: String) {
        self.imageId = imageId
        super.init()
    }
    
    func getPromotion() {
        DatabaseService.shared.getPromotion(imageId: imageId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let promotion):
                self.promotionDataSourse.send(promotion)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
