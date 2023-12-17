//
//  FurshetInfoViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 21.11.2023.
//

import UIKit

class FurshetInfoViewCell: UICollectionViewCell {
    
    static let reuseID = "FurshetInfoViewCell"
    
    let imageInfo: UIImageView = {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    func setConstraints() {
        contentView.addSubview(imageInfo)
        NSLayoutConstraint.activate([
            imageInfo.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageInfo.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
