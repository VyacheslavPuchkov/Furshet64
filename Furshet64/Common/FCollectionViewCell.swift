//
//  FCollectionViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit

open class FCollectionViewCell: UICollectionViewCell, FFillableCell {

    weak var viewModel: FCellViewModel?

    // MARK: Override

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
