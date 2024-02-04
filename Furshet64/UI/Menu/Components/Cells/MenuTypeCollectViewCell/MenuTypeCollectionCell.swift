//
//  MenuTypeCollectVewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import Foundation
import UIKit

class MenuTypeCollectionCell: FCollectionViewCell {
    
    // MARK: - Constants
    enum Constants {
        enum MainView {
            static let cornerRadius: CGFloat = 20
            static let heigh: CGFloat = 32
            static let borderWidth: CGFloat = 1
        }
        enum Label {
            static let borderWidth: CGFloat = 1
        }
    }
    
    // MARK: - ViewModel
    var currentViewModel: MenuTypeCollectionCellModel? {
        viewModel as? MenuTypeCollectionCellModel
    }
    
    // MARK: - UI
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.MainView.cornerRadius
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = Constants.MainView.borderWidth
       return view
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.green
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private func
    private func configure() {
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.heightAnchor.constraint(equalToConstant: Constants.MainView.heigh)
        ])
        mainView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
    
    // MARK: - Override
    override func fill(viewModel: FCellViewModel) {
        super.fill(viewModel: viewModel)
        guard let currentViewModel else { return }
        let selected = currentViewModel.selected
        mainView.backgroundColor = selected ? UIColor.green : UIColor.clear
        mainView.layer.borderWidth = selected ? .zero : Constants.Label.borderWidth
        label.textColor = selected ? UIColor.black : UIColor.systemGreen
        label.text = currentViewModel.title
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
}
