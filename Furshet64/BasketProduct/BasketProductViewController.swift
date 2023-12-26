//
//  BasketProductViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import UIKit
import Combine

class BasketProductViewController: BaseViewController{
 
    // MARK: - ViewModel
    var viewModel: BasketProductViewModel = .shared
    
    // MARK: - Combine variable
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    var orderTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(BasketProductTableViewCell.self, forCellReuseIdentifier: BasketProductTableViewCell.reuseID)
        
        return tableView
    }()
    
    var totalLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "ИТОГО :"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH2
        
        return label
    }()
    
    var totalPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .mobileH2
        
        return label
    }()
    
    lazy var orderButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Заказать", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 6
        //button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Отменить", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 5
        //button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupOrderTableView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        totalPriceLabel.text = "\(viewModel.cost) р."
    }
    
}

// MARK: - Private func
private extension BasketProductViewController {
    
    func bind() {
        viewModel.$orders.sink { [weak self] _ in
            guard let self else { return }
            self.orderTableView.reloadData()
        }.store(in: &cancelable)
    }
    
    func setupOrderTableView() {
        orderTableView.dataSource = self
        orderTableView.delegate = self
    }
    
    // MARK: - Constrains
    func setConstraint() {
        let stack = UIStackView(views: [cancelButton, orderButton], axis: .horizontal, spacing: 15)
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        view.addSubview(totalLabel)
        NSLayoutConstraint.activate([
            totalLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -50),
            totalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        view.addSubview(totalPriceLabel)
        NSLayoutConstraint.activate([
            totalPriceLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -50),
            totalPriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        view.addSubview(orderTableView)
        NSLayoutConstraint.activate([
            orderTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            orderTableView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -16)
        ])
    }
    
}

// MARK: - UITableViewDelegate
extension BasketProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketProductTableViewCell.reuseID, for: indexPath) as? BasketProductTableViewCell
        cell?.productTitle.text = viewModel.orders[indexPath.row].product.title
        cell?.productPrice.text = "\(viewModel.orders[indexPath.row].cost) р."
        cell?.productQuantity.text = "\(viewModel.orders[indexPath.row].count) шт."
        return cell ?? UITableViewCell()
    }
    
}

