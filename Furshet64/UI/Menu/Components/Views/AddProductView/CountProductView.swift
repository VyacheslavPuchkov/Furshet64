//
//  CountProductView.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 23.01.2024.
//
import UIKit

class CountProductView: UIView {
    
    // MARK: - UI
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.text = "1"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let buttonPlus: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .light, scale: .large)
        let largeBoldDoc = UIImage(systemName: "plus.square", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .systemGreen

        return button
    }()
    
    let buttonMinus: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .light, scale: .large)
        let largeBoldDoc = UIImage(systemName: "minus.square", withConfiguration: largeConfig)
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
        let stack = UIStackView(views: [buttonMinus, label, buttonPlus], axis: .horizontal, spacing: 10)
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
        layer.borderColor = UIColor.systemGreen.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 6
    }
}

