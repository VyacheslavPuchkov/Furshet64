//
//  BasketProductViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import UIKit

class BasketProductViewController: BaseViewController{
 
    var viewModel: BasketProductViewModel = .init()
    
    var orderTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(BasketProductTableViewCell.self, forCellReuseIdentifier: BasketProductTableViewCell.reuseID)
        
        return tableView
    }()
    
    var totalLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "ИТОГО :"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH2
        
        return label
    }()
    
    var totalPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "1000 р"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH2
        
        return label
    }()
    
    lazy var orderButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Оформить заказ", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 6
        //button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        orderTableView.dataSource = self
        orderTableView.delegate = self
    }
    
    private func setConstraint() {
        view.addSubview(orderButton)
        NSLayoutConstraint.activate([
            orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
        ])
        
        view.addSubview(totalLabel)
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 16),
            totalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        view.addSubview(totalPriceLabel)
        NSLayoutConstraint.activate([
            totalPriceLabel.topAnchor.constraint(equalTo: orderButton.bottomAnchor, constant: 16),
            totalPriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        view.addSubview(orderTableView)
        NSLayoutConstraint.activate([
            orderTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            orderTableView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -16)
        ])
    }
    
}

extension BasketProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketProductTableViewCell.reuseID, for: indexPath) as? BasketProductTableViewCell
        
        return cell ?? UITableViewCell()
    }
    
}

