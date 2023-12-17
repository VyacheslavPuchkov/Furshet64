//
//  MenyTypeCollectionViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 23.10.2023.
//

import UIKit

class MenyTypeCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "MenuTypeCell"
    
//    var imageTypeProduct: UIImageView = {
//        let image: UIImageView = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 15
//        image.backgroundColor = .black
//        return image
//    }()
    
    var titleMenyTypeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstaints()
    }
    
//    func setFoto(title: String) {
//        StorageService.shared.dowloadPicture(picName: title, ref: StorageService.shared.typeProductRef) { pic in
//                DispatchQueue.main.async { [weak self] in
//                    guard let self else { return }
//                    self.imageTypeProduct.image = pic.first
//                }
//            }
//        }
    
    private func setConstaints() {
        contentView.addSubview(titleMenyTypeLabel)
        NSLayoutConstraint.activate([
            titleMenyTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleMenyTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleMenyTypeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleMenyTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
//        contentView.addSubview(imageTypeProduct)
//        NSLayoutConstraint.activate([
//            imageTypeProduct.topAnchor.constraint(equalTo: titleMenyTypeLabel.bottomAnchor),
//            imageTypeProduct.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            imageTypeProduct.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            imageTypeProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

