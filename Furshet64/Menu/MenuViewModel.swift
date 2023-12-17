//
//  MenuViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.12.2023.
//

import UIKit
import Combine

class MenuViewModel: NSObject {
    
    var dataSourse = CurrentValueSubject<[Product], Never>([])
    
    override init() {
        super.init()
    }
    
    func getProduct() {
        DatabaseService.shared.getProduct { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let product):
                self.dataSourse.send(product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
