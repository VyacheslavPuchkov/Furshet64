//
//  ProductViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

//import Foundation
//import Combine
//import FirebaseFirestore
//import FirebaseStorage
//
//class MenuViewModel: NSObject  {
//
//    // MARK: - Combine
//    var dataSourseTypeProduct = CurrentValueSubject<[MenuType], Never>([])
//    var dataSourseProduct = CurrentValueSubject<[Product], Never>([])
//
//    // MARK: - Init
//    override init() {
//        super.init()
//    }
//
//    // MARK: - Func
//    func getMenuTypeProduct() {
//        DatabaseService.shared.getTypeProduct { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let type):
//                var filters = type
//                if filters.count > .zero {
//                    filters[.zero].selected = true
//                }
//                self.dataSourseTypeProduct.send(filters)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//    func getProduct(productType: String) {
//        DatabaseService.shared.getProduct(productType: productType) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let products):
//                self.dataSourseProduct.send(products)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
////    func addOrder(_ order: OrderModel) {
////        BasketProductManager.shared.addOrder(order)
////        }
////    
//}
//
