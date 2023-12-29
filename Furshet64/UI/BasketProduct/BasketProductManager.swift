//
//  BasketProductManager.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 16.12.2023.
//

import UIKit
import Combine

class BasketProductManager: NSObject {
    
    // MARK: - Static constant
    static let shared = BasketProductManager()
    
    // MARK: - Variable
    @Published var order: [Position] = []
    @Published var cost: Int = .zero
    
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - Init
    override init() {
        super.init()
        bind()
    }
    
    // MARK: - Func
    func bind() {
        $order.sink { [weak self] order in
            guard let self else { return }
            var sum = 0
            for position in order {
                sum += position.cost
            }
            self.cost = sum
        }.store(in: &cancelable)
    }
    
    func addPosition(_ position: Position) {
//        var currentPosition = position
//        currentPosition.count = count
        self.order.append(position)
    }
    
}
