//
//  BasketProductViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import UIKit
import Combine
import MessageUI

class BasketProductViewController: BaseViewController {
    
    // MARK: - Constants
    enum Constants {
        enum OrderButton {
            static let size = CGSize(width: 200, height: 40)
        }
        enum CancelButton {
            static let size = CGSize(width: 150, height: 40)
        }
        enum StackButton {
            static let insets = UIEdgeInsets(top: .zero, left: .zero, bottom: -100, right: .zero)
        }
        enum TotalLabel {
            static let insets = UIEdgeInsets(top: .zero, left: 16, bottom: -50, right: .zero)
        }
        enum TotalPriceLabel {
            static let insets = UIEdgeInsets(top: .zero, left: .zero, bottom: -50, right: -16)
        }
        enum TableView {
            static let insets = UIEdgeInsets(top: 200, left: 16, bottom: -16, right: 16)
        }
    }
 
    // MARK: - Manager
    var basketManager: BasketProductManager = .shared
    
    // MARK: - Combine variable
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
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
        let size = Constants.OrderButton.size
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Заказать", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(setOrder), for: .touchUpInside)
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button: UIButton = UIButton()
        let size = Constants.CancelButton.size
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Отменить", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(removeOrder), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupTabletView()
        receivingAlert()
        self.basketManager.displayView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        receivingCost()
    }
    
    @objc func removeOrder() {
        basketManager.cellModels.removeAll()
        basketManager.positions.removeAll()
        tableView.reloadData()
        totalPriceLabel.text = "0 р."
    }
    
    @objc func setOrder() {
        basketManager.addOrder()
        basketManager.alertTwoSucceessTrigger.sink { [weak self] () in
            guard let self else { return }
            self.alertChange(titleAlert: "Спасибо за заказ", messageAlert: "В ближайшее время с вами свяжется оператор") { _ in
                self.navigationController?.tabBarController?.selectedIndex = 0
                self.removeOrder()
            }
        }.store(in: &cancelable)
    }
    
}

// MARK: - Private func
private extension BasketProductViewController {

    func receivingAlert() {
        basketManager.alertSucceessTrigger.sink { [weak self] () in
            guard let self else { return }
            self.alertChange(titleAlert: "Внимание", messageAlert: "Для заказа необходимо авторизоваться") { _ in
                let vc = AuthViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } comletionNo: { _ in
                self.navigationController?.tabBarController?.selectedIndex = 0
            }
        }.store(in: &cancelable)
    }
    
    func receivingCost() {
        basketManager.$cost.sink { [weak self] cost in
            guard let self else { return }
            self.totalPriceLabel.text = "\(self.basketManager.cost) р."
        }.store(in: &cancelable)
        
        basketManager.$positions.sink { [weak self] _ in
            guard let self else { return }
            self.tableView.reloadData()
        }.store(in: &cancelable)
    }
    
    func setupTabletView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderTableCell.self, forCellReuseIdentifier: "OrderTableCell")
    }
    
    // MARK: - Configure
    func configure() {
        let insetsStack = Constants.StackButton.insets
        let insetsTotalLabel = Constants.TotalLabel.insets
        let insetsTotalPriceLabel = Constants.TotalPriceLabel.insets
        let insetsTableView = Constants.TableView.insets
        let stack = UIStackView(views: [cancelButton, orderButton], axis: .horizontal, spacing: 15)
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insetsStack.bottom)
        ])
        view.addSubview(totalLabel)
        NSLayoutConstraint.activate([
            totalLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: insetsTotalLabel.bottom),
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insetsTotalLabel.left)
        ])
        view.addSubview(totalPriceLabel)
        NSLayoutConstraint.activate([
            totalPriceLabel.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: insetsTotalPriceLabel.bottom),
            totalPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insetsTotalPriceLabel.right)
        ])
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: insetsTableView.top),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insetsTableView.left),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insetsTableView.right),
            tableView.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: insetsTableView.bottom)
        ])
    }
    
}

// MARK: - UITableViewDelegate

extension BasketProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketManager.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = basketManager.cellModels[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellIdentifier, for: indexPath)
        guard let baseCell = cell as? FTableViewCell else { return cell }
        cellModel.fillableCell = baseCell
        return baseCell
    }
}

extension BasketProductViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    
    // отправка заказа на email. Добавить в setOrder()
    //            if MFMailComposeViewController.canSendMail() {
    //                let mail = MFMailComposeViewController()
    //                mail.mailComposeDelegate = self
    //                mail.setToRecipients(["you@yoursite.com"])
    //                mail.setSubject("Email Subject Here")
    //                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
    //                present(mail, animated: true)
    //            } else {
    //                print("Application is not able to send an email")
    //            }
}
