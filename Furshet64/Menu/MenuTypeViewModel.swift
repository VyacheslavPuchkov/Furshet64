//
//  ProductViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseStorage

class MenuTypeViewModel: NSObject  {
    
    var dataSourseTypeProduct = CurrentValueSubject<[MenuTypeProduct], Never>([])
    var dataSourseProduct = CurrentValueSubject<[Product], Never>([])
    
    override init() {
        super.init()
    }
    
    func getMenuTypeProduct() {
        DatabaseService.shared.getTypeProduct { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let type):
                self.dataSourseTypeProduct.send(type)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProduct() {
        DatabaseService.shared.getProduct { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.dataSourseProduct.send(products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

