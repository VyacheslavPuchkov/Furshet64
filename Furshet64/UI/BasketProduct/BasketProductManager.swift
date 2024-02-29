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

    // MARK: - Func
    func addPosition(_ position: Position) {
        self.positions.append(position)
        
    }

    func removeOrder() {
        positions.removeAll()
    }
    
}

