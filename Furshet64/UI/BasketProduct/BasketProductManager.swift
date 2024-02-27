//
//  BasketProductManager.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 16.12.2023.
//

import UIKit
import Combine
import FirebaseAuth

class BasketProductManager: NSObject {
    
    // MARK: - Static constant
    static let shared = BasketProductManager()
    
    // MARK: - Variable
    @Published var positions: [Position] = []
    @Published var cost: Int = .zero
    @Published var cellModels: [FCellViewModel] = []
    
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    var alertSucceessTrigger = PassthroughSubject<Void, Never>()
    var alertTwoSucceessTrigger = PassthroughSubject<Void, Never>()
    var test: ChangeCountProduct?
    
    // MARK: - Init
    override init() {
        super.init()
        receivingPosition()
        print(positions)
    }
    
    // MARK: - Func
    func receivingPosition() {
        $positions.sink { [weak self] order in
            guard let self else { return }
            var sum = 0
            for position in order {
                sum += position.cost
            }
            self.cost = sum
        }.store(in: &cancelable)
    }
    
    func displayView() {
        guard Auth.auth().currentUser?.uid != nil else { return self.alertSucceessTrigger.send() }
    }
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
        makeViewModels(for: positions)
    }
    
    func addOrder() {
        guard let userId = Auth.auth().currentUser?.uid else { return self.alertSucceessTrigger.send() }
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
    
    private func makeViewModels(for order: [Position]) {
        cellModels = []
        order.forEach { cellModels.append(
            OrderTableCellModel(id: UUID().uuidString, product: .init(id: UUID().uuidString, title: $0.product.title, price: $0.product.price, typeProduct: $0.product.typeProduct, weight: $0.product.weight, compound: $0.product.compound), count: $0.count, cost: $0.cost))
        }
    }
    
    func removeOrder() {
        positions.removeAll()
    }
    
}
