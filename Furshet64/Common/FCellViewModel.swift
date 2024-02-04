//
//  FCellViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit

class FCellViewModel: Hashable, Equatable {
    weak var fillableCell: FFillableCell? {
        didSet {
            bind(with: fillableCell)
            fillableCell?.fill(viewModel: self)
        }
    }
    public let cellIdentifier: String
    private var dataHash: Int
    
    public init(cellIdentifier: String, dataHash: Int = UUID().hashValue) {
        self.cellIdentifier = cellIdentifier
        self.dataHash = dataHash
    }
    
    public static func == (lhs: FCellViewModel, rhs: FCellViewModel) -> Bool {
        lhs.isEqual(to: rhs)
    }
    
    open func isEqual(to viewModel: FCellViewModel) -> Bool {
        type(of: self) == type(of: viewModel)
    }
    
    open func bind(with fillableCell: FFillableCell?) {
        // override in subclasses
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(dataHash)
    }
}
