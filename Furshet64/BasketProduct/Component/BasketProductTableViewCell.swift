//
//  BasketProductTableViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import UIKit

class BasketProductTableViewCell: UITableViewCell {
    
    // MARK: - Static constants
    static let reuseID = "BasketProductTableViewCell"
    
    // MARK: - UI
    var productTitle: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = .mobileH3
        return label
    }()
    
    var productQuantity: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH3
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    
    var productPrice: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH3
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setConstaints()
        
    }
    
    //MARK: - Constraints
    private func setConstaints() {
        let stack = UIStackView(views: [productTitle, productQuantity, productPrice], axis: .horizontal, spacing: 2)
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    //MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
