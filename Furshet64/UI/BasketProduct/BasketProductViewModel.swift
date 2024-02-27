//
//  BasketProductViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.02.2024.
//

import Foundation

protocol ChangeCountProduct {
    func addProduct(viewModel: OrderTableCellModel?, view: CountProductView)
    func deleteProduct(viewModel: OrderTableCellModel?, view: CountProductView)
}

class BasketProductViewModel: NSObject {
    
}

extension BasketProductViewModel: ChangeCountProduct {
    func deleteProduct(viewModel: OrderTableCellModel?, view: CountProductView) {
        guard let viewModel else { return }
        viewModel.count += 1
        view.label.text = "\(viewModel.count)"
        viewModel.cost = viewModel.count * viewModel.product.price
    }
    
    func addProduct(viewModel: OrderTableCellModel?, view: CountProductView) {
        guard let viewModel else { return }
        guard viewModel.count > 1 else { return }
        viewModel.count -= 1
        view.label.text = "\(viewModel.count)"
        viewModel.cost = viewModel.count * viewModel.product.price
    }
    
}

    

