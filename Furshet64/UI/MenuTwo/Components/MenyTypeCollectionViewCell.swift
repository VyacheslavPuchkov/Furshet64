//
//  MenyTypeCollectionViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 23.10.2023.
//

//import UIKit
//
//class MenyTypeCollectionViewCell: UICollectionViewCell {
//    
//    static let reuseID = "MenuTypeCell"
//    
//    var titleMenyTypeLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .black
//        label.textAlignment = .center
//        label.font = .bodyLarge2
//        label.numberOfLines = 3
//        return label
//        
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setConstaints()
//    }
//    
//    func configureCell(with menuType: MenuTypeProduct) {
//        titleMenyTypeLabel.text = menuType.title
//        contentView.backgroundColor = menuType.selected ? .black.withAlphaComponent(0.1) : .clear
//        layer.cornerRadius = 5
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.black.cgColor
//    }
//    
//    private func setConstaints() {
//        contentView.addSubview(titleMenyTypeLabel)
//        NSLayoutConstraint.activate([
//            titleMenyTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            titleMenyTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            titleMenyTypeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            titleMenyTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//        
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
