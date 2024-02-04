//
//  AddProductView.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit

class AddProductView: UIView {
    
    // MARK: - UI
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 19, weight: .light, scale: .large)
        let largeBoldDoc = UIImage(systemName: "basket", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    private func configure() {
        let stack = UIStackView(views: [label, button], axis: .horizontal, spacing: 10)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        let insets = UIEdgeInsets(top: 3, left: 3, bottom: -3, right: -3)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
    }
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.statusGreen.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 6
    }
}

