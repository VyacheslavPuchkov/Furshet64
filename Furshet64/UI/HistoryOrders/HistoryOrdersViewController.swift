//
//  HistoryOrdersViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 31.12.2023.
//

import UIKit
import Combine

class HistoryOrdersViewController: BaseViewController {
    
    // MARK: - ViewModel
    var viewModel: HistoryOrdersViewModel = .init()
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    //MARK: - UI
    var historyOrdersTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white.withAlphaComponent(0.7)
        tableView.register(HistoryOrdersTableViewCell.self, forCellReuseIdentifier: HistoryOrdersTableViewCell.reuseID)
        return tableView
    }()

    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupHistoryOrdersTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindOrders()
        viewModel.getHistoryOrdes()
    }

}

    //MArk: - Private func
private extension HistoryOrdersViewController {
    func setConstraint() {
        view.addSubview(historyOrdersTableView)
        NSLayoutConstraint.activate([
            historyOrdersTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            historyOrdersTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            historyOrdersTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            historyOrdersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
    func setupHistoryOrdersTableView() {
        historyOrdersTableView.dataSource = self
        historyOrdersTableView.delegate = self
    }
    
    func bindOrders() {
        viewModel.dataSourse.sink { [weak self] orders in
            guard let self else { return }
            self.historyOrdersTableView.reloadData()
        }.store(in: &cancelable)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension HistoryOrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourse.value[section].posiotions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSourse.value.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = viewModel.dataSourse.value[section]
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "dd.MM.yy HH:mm"
        let date = dataFormatter.string(from: item.date)
        let sectionTitle = "Дата заказа:" + " " + date + "   " + "Сумма: \(item.cost)р."
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryOrdersCell", for: indexPath) as? HistoryOrdersTableViewCell
        let item = viewModel.dataSourse.value[indexPath.section]
        cell?.titleLabel.text = item.posiotions[indexPath.row].product.title
        cell?.countLabel.text = "\(item.posiotions[indexPath.row].count) шт."
        cell?.priceLabel.text = "\(item.posiotions[indexPath.row].cost) р."
        cell?.backgroundColor = .white.withAlphaComponent(0.3)
        return cell ?? UITableViewCell()
    }
}


