//
//  OrderCollectionViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 29.12.2023.
//

import UIKit
import Combine

class OrderCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "OrderProductCell"
    
//    var cancelable = Set<AnyCancellable>()
//
//    var tapPublisher = PassthroughSubject<(Product?, Int), Never>()
//    var product: Product?
    //@Published var count: Int = 1
    
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
        label.textColor = .black
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        
        return label
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 5
        
        return label
    }()
    
    var countLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()
    
    lazy var addStepper: UIStepper = {
        let stepper: UIStepper = UIStepper()
        stepper.layer.masksToBounds = true
        stepper.backgroundColor = .clear
        stepper.layer.cornerRadius = 6
        stepper.value = 1
        stepper.layer.cornerRadius = 3
        stepper.layer.borderWidth = 2
        stepper.layer.borderColor = UIColor.black.cgColor
        stepper.addTarget(self, action: #selector(actionStepper), for: .valueChanged)
        return stepper
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFoto(title: String) {
        StorageService.shared.dowloadPicture(picName: title, ref: StorageService.shared.productRef) { [weak self] pic in
            guard let self else { return }
            DispatchQueue.main.async {
                self.imageProduct.image = pic.first
            }
        }
    }
    
    func configureCell(with position: Position) {
        //cell?.setFoto(title: position.product.id + ".jpg") Получение картинки из базы данных
        titleLabel.text = position.product.title
        countLabel.text = "\(position.count) шт."
        priceLabel.text = "\(position.cost) р."
        imageProduct.image = UIImage(named: "productFoto")
        backgroundColor = .white.withAlphaComponent(0.5)
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
    private func setConstaints() {
        contentView.addSubview(imageProduct)
        NSLayoutConstraint.activate([
            imageProduct.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageProduct.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageProduct.rightAnchor.constraint(equalTo: contentView.leftAnchor, constant: 160),
            imageProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        let stack = UIStackView(views: [countLabel, addStepper], axis: .horizontal, spacing: 10)
        let finalStack = UIStackView(views: [titleLabel, stack , priceLabel], axis: .vertical, spacing: 1)
        contentView.addSubview(finalStack)
        finalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            finalStack.leftAnchor.constraint(equalTo: imageProduct.rightAnchor, constant: 10),
            finalStack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            finalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc func actionStepper(_ target: UIStepper) {
        countLabel.text = "\(Int(target.value)) шт."
    }
//
//    @objc func actionButton() {
//        tapPublisher.send((product, count))
//    }
//

}

