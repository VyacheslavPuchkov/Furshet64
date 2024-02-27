//
//  MenuViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//
//
import Foundation
import FirebaseFirestore
import Combine
import UIKit

class MenuViewModel: NSObject {
    
    // MARK: - Combine
    var dataSourseTypeProduct = CurrentValueSubject<[MenuType], Never>([])
    var dataSourseProduct = CurrentValueSubject<[Product], Never>([])
    
    // MARK - Model
    @Published var cellModels: [FCellViewModel] = []
    
    let promoCellModel = PromoBanerCellModel()
    
    // MARK: - Init
    override init() {
        super.init()
        getMenuTypeProduct()
    }
    
    // MARK: - Func
    func getMenuTypeProduct() {
        DatabaseService.shared.getTypeProduct { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let type):
                var filters = type
                if filters.count > .zero {
                    filters[.zero].selected = true
                    self.getProduct(productType: filters.first?.title ?? "")
                }
                self.dataSourseTypeProduct.send(filters)
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
                self.makeViewModels(for: products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    // MARK: - Private func
    private func makeViewModels(for products: [Product]) {
//        var testCellModels: [FCellViewModel] = []
        cellModels = []
        products.forEach { cellModels.append(
            ProductCellModel(image: UIImage(named: "productFoto"), name: $0.title, compound: $0.compound, price: $0.price, id: $0.id, count: 1, typeProduct: $0.typeProduct, weight: $0.weight))
        }
//        cellModels = testCellModels
    }
        
}
