//
//  MenyTypeCollectionViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 23.10.2023.
//

import UIKit

class MenyTypeCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "MenuTypeCell"
    
    var titleMenyTypeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .bodyLarge2
        label.numberOfLines = 3
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstaints()
    }
    
    private func setConstaints() {
        contentView.addSubview(titleMenyTypeLabel)
        NSLayoutConstraint.activate([
            titleMenyTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleMenyTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleMenyTypeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleMenyTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

