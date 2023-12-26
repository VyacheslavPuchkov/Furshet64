//
//  MenyProductCollectionViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.11.2023.
//

import UIKit
import Combine

class MenyProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "MenuProductCell"
    
    var tapPublisher = PassthroughSubject<Void, Never>()
    @Published var count: Int = 1
    
    var imageProduct: UIImageView = {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        image.backgroundColor = .black
        
        return image
    }()
    
    var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        
        return label
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 5
        
        return label
    }()
    
    var countLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.text = "1"
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    lazy var addStepper: UIStepper = {
        let stepper: UIStepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(actionStepper), for: .valueChanged)
        stepper.backgroundColor = .white
        stepper.value = 1
        return stepper
    }()
    
    lazy var addButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.masksToBounds = true
        button.setTitle("В корзину", for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.8)
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstaints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageProduct.image = UIImage()
        count = 1
        countLabel.text = "1"
        addStepper.value = 1
    }
    
    func setFoto(title: String) {
        StorageService.shared.dowloadPicture(picName: title, ref: StorageService.shared.productRef) { [weak self] pic in
            guard let self else { return }
            DispatchQueue.main.async {
                self.imageProduct.image = pic.first
            }
        }
    }
    
    private func setConstaints() {
        contentView.addSubview(imageProduct)
        NSLayoutConstraint.activate([
            imageProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageProduct.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageProduct.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageProduct.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 150)
        ])
        let stack = UIStackView(views: [countLabel, addStepper], axis: .horizontal, spacing: 20)
        let finalStack = UIStackView(views: [titleLabel, stack, priceLabel, addButton], axis: .vertical, spacing: 1)
        contentView.addSubview(finalStack)
        finalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finalStack.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: 5),
            finalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            finalStack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            finalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func actionStepper(_ target: UIStepper) {
        count = Int(target.value)
        countLabel.text = "\(count)"
    }
    
    @objc func actionButton() {
        tapPublisher.send(())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
