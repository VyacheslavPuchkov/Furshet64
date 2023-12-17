//
//  BasketProductTableViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import UIKit

class BasketProductTableViewCell: UITableViewCell {
    
    static let reuseID = "BasketProductTableViewCell"
    
    var productTitle: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH5
        
        return label
    }()
   
    var productQuantity: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH5
        
        return label
    }()
    
    var productPrice: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH5
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setConstaints()
        
    }
    
    private func setConstaints() {
        let stack = UIStackView(views: [productTitle, productQuantity, productPrice], axis: .horizontal, spacing: 1)
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
