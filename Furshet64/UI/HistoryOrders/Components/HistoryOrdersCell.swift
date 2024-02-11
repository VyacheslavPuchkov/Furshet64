//
//  HistoryOrdersCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 06.02.2024.
//

import Foundation
import UIKit

class HistoryOrdersTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    enum Constants {
        static let size = CGSize(width: 220, height: .zero)
    }

    //MARK: - Static constants
    static let reuseID = "HistoryOrdersCell"
    
    //MARK: - UI
    var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        label.numberOfLines = 5
        
        return label
    }()
    
    var countLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private func
    private func setConstaints() {
        let stack = UIStackView(views: [titleLabel, countLabel, priceLabel], axis: .horizontal, spacing: 10)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
