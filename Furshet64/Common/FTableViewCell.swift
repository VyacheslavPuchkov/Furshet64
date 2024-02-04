//
//  FTableViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit

open class FTableViewCell: UITableViewCell, FFillableCell {

    weak var viewModel: FCellViewModel?

    // MARK: Override
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        resetReferences()
    }

    // MARK: Public - Can override

    func fill(viewModel: FCellViewModel) {
        self.viewModel = viewModel
    }

    private func resetReferences() {
        viewModel?.fillableCell = nil
        viewModel = nil
    }
}
