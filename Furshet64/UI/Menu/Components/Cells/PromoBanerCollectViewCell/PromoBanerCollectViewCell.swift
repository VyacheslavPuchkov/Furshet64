//
//  PromoBanerCollectViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit

class PromoBanerCollectionCell: FCollectionViewCell {
    
    // MARK: - ViewModel
    var currentViewModel: PromoBanerCollectionCellModel? {
        viewModel as? PromoBanerCollectionCellModel
    }
    
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    private func configure() {
        configureImage()
        configureView()
    }
    
    private func configureImage() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 112)
        ])
        imageView.backgroundColor = .clear
    }
    
    private func configureView() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    // MARK - Func network request
    func setFoto(title: String) {
        StorageService.shared.dowloadPicture(picName: title, ref: StorageService.shared.bannerRef) { [weak self] pic in
            guard let self else { return }
            DispatchQueue.main.async {
                self.imageView.image = pic.first
            }
        }
    }
    
    // MARK: - Override
    override func fill(viewModel: FCellViewModel) {
        super.fill(viewModel: viewModel)
        guard let currentViewModel else { return }
        setFoto(title: currentViewModel.imageName)
    }
    
}
