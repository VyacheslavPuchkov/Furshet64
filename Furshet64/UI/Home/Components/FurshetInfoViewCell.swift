//
//  FurshetInfoViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 21.11.2023.
//

import UIKit

class FurshetInfoViewCell: UICollectionViewCell {
    
    // MARK: - Static constants
    static let reuseID = "FurshetInfoViewCell"
    
    // MARK: - UI
    let imageInfo: UIImageView = {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        contentView.addSubview(imageInfo)
        NSLayoutConstraint.activate([
            imageInfo.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageInfo.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
