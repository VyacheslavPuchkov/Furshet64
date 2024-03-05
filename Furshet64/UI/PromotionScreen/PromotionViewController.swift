//
//  PromotionViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 04.03.2024.
//

import UIKit
import Combine

enum Constants {
    enum ImageView {
        static let insets = UIEdgeInsets(top: 16, left: 16, bottom: .zero, right: 16)
    }
    enum PromotionTitle {
        static let insets = UIEdgeInsets(top: 16, left: .zero, bottom: .zero, right: .zero)
        static let size = CGSize(width: 350, height: 50)
    }
    enum PromotionDescription {
        static let insets = UIEdgeInsets(top: 32, left: 16, bottom: 16, right: .zero)
    }
    
}

class PromotionViewController: UIViewController {
    
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let promotionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: Constants.PromotionTitle.size.width).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.PromotionTitle.size.height).isActive = true
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .systemGreen
        label.font = .mobileH2
        return label
    }()
    
    private let promotionDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .systemGreen
        textView.font = .mobileH5
        
        return textView
    }()
    
    private let validityTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .systemGreen
        textView.font = .mobileH5
        
        return textView
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Private func
    private func configure() {
        let insetsImageView = Constants.ImageView.insets
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: insetsImageView.top),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insetsImageView.left),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insetsImageView.right)
        ])
        let insetsLabel = Constants.PromotionTitle.insets
        view.addSubview(promotionTitleLabel)
        NSLayoutConstraint.activate([
            promotionTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: insetsLabel.top)
        ])
        let insetsTextView = Constants.PromotionDescription.insets
        view.addSubview(promotionDescriptionTextView)
        NSLayoutConstraint.activate([
            promotionDescriptionTextView.topAnchor.constraint(equalTo: promotionTitleLabel.topAnchor, constant: insetsTextView.top),
            promotionDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insetsTextView.left),
            promotionDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insetsTextView.right)
        ])
        
    }
}
