//
//  MenuViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 17.01.2024.
//

import UIKit
import Combine

class MenuViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel = MenuViewModel()
    
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    var header: MenuTypeView?
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupTableView()
        receivingProduct()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Private func
    private func configure() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PromoBanerCell.self, forCellReuseIdentifier: "PromoBanerCell")
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
    }
    
        // MARK: - Combine
        func receivingProduct() {
            viewModel.$cellModels.sink { [weak self] _ in
                guard let self else { return }
                self.tableView.reloadData()
            }.store(in: &cancelable)
        }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == .zero {
            return nil
        } else {
            if let header {
                return header
            } else {
                if viewModel.dataSourseTypeProduct.value.isEmpty {
                    return nil
                } else {
                    header = MenuTypeView(filters: viewModel.dataSourseTypeProduct.value, delegate: self)
                    return header
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 56 : .zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .zero {
            return 1
        } else {
            return viewModel.cellModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.promoCellModel.cellIdentifier, for: indexPath)
            guard let baseCell = cell as? FTableViewCell else { return cell }
            viewModel.promoCellModel.fillableCell = baseCell
            return baseCell
        } else {
            let cellModel = viewModel.cellModels[indexPath.item]
            let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
            guard let baseCell = cell as? FTableViewCell else { return cell }
            cellModel.fillableCell = baseCell
            return baseCell
        }
    }
}

// MARK - FiltersViewAction
extension MenuViewController: MenuTypeViewAction {
    func didTap(id: String) {
        guard let header else { return }
        header.cellModels.compactMap { $0 as? MenuTypeCollectionCellModel }.indices.forEach { value in
            header.cellModels.compactMap { $0 as? MenuTypeCollectionCellModel }[value].selected = header.cellModels.compactMap({ $0 as? MenuTypeCollectionCellModel })[value].title == id
        }
        viewModel.getProduct(productType: id)
    }
}
    
