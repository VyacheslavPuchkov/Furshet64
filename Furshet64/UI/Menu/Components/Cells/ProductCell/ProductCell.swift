//
//  ProductCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit
import Combine

class ProductCell: FTableViewCell {
    
    // MARK: - Constants
    enum Constants {
        enum ImageView {
            static let size = CGSize(width: 132, height: 132)
            static let insets = UIEdgeInsets(top: 24, left: 16, bottom: -16, right: .zero)
        }
        enum NameLabel {
            static let insets = UIEdgeInsets(top: 9, left: 32, bottom: .zero, right: -24)
        }
        enum DescriptionLabel {
            static let insets = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        }
        enum AddProductView {
            static let insets = UIEdgeInsets(top: 16, left: .zero, bottom: -16, right: -16)
        }
        enum CountProductView {
            static let insets = UIEdgeInsets(top: 16, left: .zero, bottom: -16, right: -32)
        }
    }
    
    // MARK: - View
    let addProductView = AddProductView()
    let countProductView = CountProductView()
    
    // MARK: - ViewModel
    var currentViewModel: ProductCellModel? {
        viewModel as? ProductCellModel
    }
    
    var tapPublisher = PassthroughSubject<(Product?, Int), Never>()
    
    var product: Product?
    @Published var count: Int = 1
    
    // MARK: - UI
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    private func configure() {
        configureImageView()
        configureNameLabel()
        configureDescriptionLabel()
        configureAddProductView()
        configureCountProductView()
    }
    
    private func configureImageView() {
        let size = Constants.ImageView.size
        let insets = Constants.ImageView.insets
        contentView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: size.width),
            productImageView.heightAnchor.constraint(equalToConstant: size.height),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets.top),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets.left),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    private func configureNameLabel() {
        let insets = Constants.NameLabel.insets
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: insets.top),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: insets.left),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: insets.right)
        ])
    }
    
    private func configureDescriptionLabel() {
        let insets = Constants.ImageView.insets
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: insets.top),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    private func configureAddProductView() {
        let insets = Constants.AddProductView.insets
        contentView.addSubview(addProductView)
        NSLayoutConstraint.activate([
            addProductView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: insets.top),
            addProductView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            addProductView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    private func configureCountProductView() {
        let insets = Constants.CountProductView.insets
        contentView.addSubview(countProductView)
        NSLayoutConstraint.activate([
            countProductView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: insets.top),
            countProductView.trailingAnchor.constraint(equalTo: addProductView.leadingAnchor, constant: insets.right),
            countProductView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: insets.bottom)
        ])
    }
    
    // MARK - Func network request
    func setFoto(title: String) {
        StorageService.shared.dowloadPicture(picName: title, ref: StorageService.shared.productRef) { [weak self] pic in
            guard let self else { return }
            DispatchQueue.main.async {
                self.productImageView.image = pic.first
            }
        }
    }
    
    // MARK: - Override
    override func fill(viewModel: FCellViewModel) {
        super.fill(viewModel: viewModel)
        guard let currentViewModel else { return }
        nameLabel.text = currentViewModel.name
        descriptionLabel.text = currentViewModel.compound
        addProductView.label.text = "\(currentViewModel.price) р."
        addProductView.button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        //setFoto(title: currentViewModel.id + ".jpg")  //На сервере нет фото
        productImageView.image = UIImage(named: "productFoto")
        countProductView.buttonPlus.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
        countProductView.buttonMinus.addTarget(self, action: #selector(deleteProduct), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = UIImage()
        countProductView.label.text = "1"
        count = 1
    }
    
    @objc func addProduct() {
        count += 1
        countProductView.label.text = "\(count)"
        guard let price = currentViewModel?.price else { return }
        addProductView.label.text = "\(price * count) р."
    }
    
    @objc func deleteProduct() {
        if count > 1 {
            count -= 1
        }
        countProductView.label.text = "\(count)"
        guard let price = currentViewModel?.price else { return }
        addProductView.label.text = "\(price * count) р."
    }
    
    @objc func actionButton() {
        guard let currentViewModel else { return }
        let id = currentViewModel.id
        let title = currentViewModel.name
        let price = currentViewModel.price
        let typeProduct = currentViewModel.typeProduct
        let weight = currentViewModel.weight
        let compound = currentViewModel.compound
        BasketProductManager.shared.addPosition(.init(id: UUID().uuidString, product: .init(id: id, title: title, price: price, typeProduct: typeProduct, weight: weight, compound: compound), count: count))
    }
    
}
