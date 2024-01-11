//
//  BasketProductViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 27.10.2023.
//

import UIKit
import Combine
import MessageUI

class BasketProductViewController: BaseViewController{
 
    // MARK: - Manager
    var basketManager: BasketProductManager = .shared
    
    // MARK: - Combine variable
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    let collectViewOrder: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 150)
        layout.sectionInset = .init(top: .zero, left: 16, bottom: .zero, right: 16)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OrderCollectionViewCell.self, forCellWithReuseIdentifier: OrderCollectionViewCell.reuseID)
        return collectionView
        
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
        button.addTarget(self, action: #selector(setOrder), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(removeOrder), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupOrderCollectView()
        bindAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.basketManager.displayView()
        collectViewOrder.reloadData()
        bind()
    }
    
    @objc func removeOrder() {
        basketManager.removeOrder()
        totalPriceLabel.text = "0 р."
    }
    
    @objc func setOrder() {
        basketManager.addOrder()
        basketManager.succeessTrigger.sink { [weak self] () in
            guard let self else { return }
            self.alertChange(titleAlert: "Спасибо за заказ", messageAlert: "В ближайшее время с вами свяжется оператор") { _ in
                self.navigationController?.tabBarController?.selectedIndex = 0
            }
        }.store(in: &cancelable)
    }
    
}

// MARK: - Private func
private extension BasketProductViewController {

    func bindAlert() {
        basketManager.succeessTrigger.sink { [weak self] () in
            guard let self else { return }
            self.alertChange(titleAlert: "Внимание", messageAlert: "Для заказа необходимо авторизоваться") { _ in
                let vc = AuthViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } comletionNo: { _ in
                self.navigationController?.tabBarController?.selectedIndex = 0
            }
        }.store(in: &cancelable)
    }
    
    func bind() {
        basketManager.$cost.sink { [weak self] cost in
            guard let self else { return }
            self.totalPriceLabel.text = "\(self.basketManager.cost) р."
        }.store(in: &cancelable)
        
        basketManager.$positions.sink { [weak self] _ in
            guard let self else { return }
            self.collectViewOrder.reloadData()
        }.store(in: &cancelable)
    }
    
    func setupOrderCollectView() {
        collectViewOrder.dataSource = self
        collectViewOrder.delegate = self
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
        view.addSubview(collectViewOrder)
        NSLayoutConstraint.activate([
            collectViewOrder.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            collectViewOrder.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            collectViewOrder.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            collectViewOrder.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -16)
        ])
    }
    
}

// MARK: - UICollectionViewDelegate

extension BasketProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basketManager.positions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.reuseID, for: indexPath) as? OrderCollectionViewCell
        let position = basketManager.positions[indexPath.row]
        cell?.configureCell(with: position)
        return cell ?? UICollectionViewCell()
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
