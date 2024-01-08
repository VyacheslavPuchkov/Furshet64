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
    
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    var alertSucceessTrigger = PassthroughSubject<UIAlertController, Never>()
    var alertSucceessTriggerTwo = PassthroughSubject<UIAlertController, Never>()
    
    // MARK: - Init
    override init() {
        super.init()
        bind()
    }
    
    // MARK: - Func
    func bind() {
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
        guard Auth.auth().currentUser?.uid != nil else { return self.alertSucceessTrigger.send(UIAlertController(title: "Внимание", message: "Для заказа необходимо авторизоваться", preferredStyle: .alert))
            }
    }
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
    
    func addOrder() {
        let order = OrderModel(id: UUID().uuidString, positions: positions, userID: Auth.auth().currentUser!.uid, date: Date(), cost: cost)
        DatabaseService.shared.setOrder(order: order) { result in
            switch result {
            case .success(let order):
                print(order.cost)
                self.alertSucceessTriggerTwo.send(UIAlertController(title: "Спасибо за заказ", message: "В ближайшее время с вами свяжется оператор", preferredStyle: .alert))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeOrder() {
        positions.removeAll()
    }
    
}
