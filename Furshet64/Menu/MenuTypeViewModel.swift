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
    
    //MARK: - Variable
    var products: [Product] = .init()
    var count = 1
    
    // MARK: - Combine
    var dataSourseTypeProduct = CurrentValueSubject<[MenuTypeProduct], Never>([])
    var dataSourseProduct = CurrentValueSubject<[Product], Never>([])
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Func
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
    
    func getProduct(productType: String) {
        DatabaseService.shared.getProduct(productType: productType) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products = products
                self.dataSourseProduct.send(products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addOrder(_ order: OrderModel) {
        BasketProductViewModel.shared.addOrder(order)
        }
    
}

