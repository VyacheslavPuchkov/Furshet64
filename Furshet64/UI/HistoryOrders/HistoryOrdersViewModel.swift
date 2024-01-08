//
//  HistoryOrdersViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 31.12.2023.
//

import UIKit
import Combine

class HistoryOrdersViewModel: NSObject {
    
    var orders: [OrderModel] = []

    //MARK: - Combine
    var dataSourse = CurrentValueSubject<[OrderModel], Never>([])
    
    //MARK: - Init
    override init() {
        super.init()
    }
    
    func getHistoryOrdes() {
        guard let user = AuthService.shared.currentUser else { return }
        DatabaseService.shared.getOrders(for: user) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let orders):
                self.orders = orders
                self.orders.sort { one, two in
                    one.date > two.date
                }
                for(index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPositions(for: order.id) { [weak self] result in
                        guard let self else { return }
                        switch result {
                        case .success(let positions):
                            self.orders[index].posiotions = positions
                            self.dataSourse.send(self.orders)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
}

