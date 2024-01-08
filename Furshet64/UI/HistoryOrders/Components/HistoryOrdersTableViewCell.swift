//
//  HistoryOrdesTableViewCell.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 31.12.2023.
//

import UIKit

class HistoryOrdersTableViewCell: UITableViewCell {

    //MARK: - Static constants
    static let reuseID = "HistoryOrdersCell"
    
    //MARK: - UI
    var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.widthAnchor.constraint(equalToConstant: 220).isActive = true
        label.numberOfLines = 5
        
        return label
    }()
    
    var countLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        
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
