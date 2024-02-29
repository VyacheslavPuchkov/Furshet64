//
//  BasketProductViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.02.2024.
//

import Foundation
import Combine
import FirebaseAuth

protocol ChangeCountProduct {
    func addProduct()
    func deleteProduct()
}

class BasketProductViewModel: NSObject {
    
    // MARK: - Variable
    @Published var positions: [Position] = []
    @Published var cost: Int = .zero
    @Published var cellModels: [FCellViewModel] = []
    
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    var alertSucceessTrigger = PassthroughSubject<Void, Never>()
    var alertTwoSucceessTrigger = PassthroughSubject<Void, Never>()
    
   // MARK: - Init
    override init() {
        super.init()
        receivingPosition()
    }
    
    // MARK: - Func
    func displayView() {
        guard Auth.auth().currentUser?.uid != nil else { return self.alertSucceessTrigger.send() }
    }
    
    func receivingPosition() {
        BasketProductManager.shared.$positions.sink { [weak self] order in
            guard let self else { return }
            var sum = 0
            for position in order {
                sum += position.cost
            }
            self.cost = sum
            self.makeViewModels(for: order)
        }.store(in: &cancelable)
    }
    
    func addOrder() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let order = OrderModel(id: UUID().uuidString, positions: positions, userID: userId, date: Date(), cost: cost)
        DatabaseService.shared.setOrder(order: order) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success( _):
                self.alertTwoSucceessTrigger.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeViewModels(for order: [Position]) {
        cellModels = []
        order.forEach { cellModels.append(
            OrderTableCellModel(id: UUID().uuidString, product: .init(id: UUID().uuidString, title: $0.product.title, price: $0.product.price, typeProduct: $0.product.typeProduct, weight: $0.product.weight, compound: $0.product.compound), count: $0.count, cost: $0.cost, delegate: self))
        }
    }
    
}

extension BasketProductViewModel: ChangeCountProduct {
    func addProduct() {
       print("plus")
    }
    
    func deleteProduct() {
        print("minus")
    }
    
    
}

//extension BasketProductViewModel: ChangeCountProduct {
//    func deleteProduct(viewModel: OrderTableCellModel?, view: CountProductView) {
//        guard let viewModel else { return }
//        viewModel.count += 1
//        view.label.text = "\(viewModel.count)"
//        viewModel.cost = viewModel.count * viewModel.product.price
//    }
//
//    func addProduct(viewModel: OrderTableCellModel?, view: CountProductView) {
//        guard let viewModel else { return }
//        guard viewModel.count > 1 else { return }
//        viewModel.count -= 1
//        view.label.text = "\(viewModel.count)"
//        viewModel.cost = viewModel.count * viewModel.product.price
//    }
//
//}

    

