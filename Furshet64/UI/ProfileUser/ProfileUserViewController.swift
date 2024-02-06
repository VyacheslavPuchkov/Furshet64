//
//  ProfileUserViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 26.10.2023.
//

import UIKit
import Combine
import FlagPhoneNumber
import FirebaseAuth

class ProfileUserViewController: BaseViewController, ObservableObject {
    
    // MARK: - Constants
    enum Constants {
        static let size = CGSize(width: 350, height: 50)
        enum ExitButton {
            static let insets = UIEdgeInsets(top: .zero, left: .zero, bottom: -100, right: .zero)
        }
    }
    
    // MARK: - ViewModel
    var viewModel: ProfileUserViewModel = .init()
    // MARK: - Private variable
    private var listController: FPNCountryListViewController!
    private var profileUser: ProfileUser = .init(id: "", name: "", phone: "")
    private var signUp: Bool = true {
        willSet {
            if newValue {
                saveButton.setTitle("Изменить", for: .normal)
            } else {
                saveButton.setTitle("Сохранить", for: .normal)
            }
        }
    }
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - UI
    let nameUserTextField = UITextField(placeholderText: "Как вас зовут? Желательно с фамилией")
    
    var phoneUserTextField: FPNTextField = {
        let textField: FPNTextField = FPNTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "  Ваш номер", attributes: [NSAttributedString.Key.foregroundColor: UIColor.statusGreen])
        textField.layer.masksToBounds = true
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.textColor = .systemGreen
        textField.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        textField.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.masksToBounds = true
        button.setTitle("Изменить", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(saveActionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var historyOrdersButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.masksToBounds = true
        button.setTitle("История заказов", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(historyOrdersAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var exitButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Выйти", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(exitActionButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        myProfile()
        setupConfig()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.viewModel.displayView()
        }
    }
    
    // MARK: - Func
    @objc func exitActionButton() {
        viewModel.singOot()
        nameUserTextField.text = ""
        phoneUserTextField.text = ""
        self.navigationController?.tabBarController?.selectedIndex = 0
    }
    
    @objc func saveActionButton() {
        if signUp == false {
            nameUserTextField.isEnabled = false
            phoneUserTextField.isEnabled = false
            profileUser.phone = phoneUserTextField.text ?? ""
            profileUser.name = nameUserTextField.text ?? ""
            viewModel.setProfile(user: profileUser)
            signUp = true
        } else {
            nameUserTextField.isEnabled = true
            phoneUserTextField.isEnabled = true
            signUp = false
        }
    }
    
    @objc func historyOrdersAction() {
        let vc = HistoryOrdersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Private func
private extension ProfileUserViewController {
    
    func setupConfig() {
        nameUserTextField.isEnabled = false
        phoneUserTextField.isEnabled = false
        
        phoneUserTextField.displayMode = .list
        phoneUserTextField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController.setup(repository: phoneUserTextField.countryRepository)
        listController?.didSelect = { country in
            self.phoneUserTextField.setFlag(countryCode: country.code)
        }
    }
    
    // MARK: - Contraints
    func configure() {
        let insets = Constants.ExitButton.insets
        let stack = UIStackView(views: [nameUserTextField, phoneUserTextField, saveButton, historyOrdersButton], axis: .vertical, spacing: 5)
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Combine
    func bind() {
        viewModel.alertSucceessTrigger.sink { alert in
            let oKaction = UIAlertAction(title: "Авторизиваться", style: .default) { _ in
                let vc = AuthViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            let noAction = UIAlertAction(title: "Без изменений", style: .default) { _ in
                self.navigationController?.tabBarController?.selectedIndex = 0
            }
            alert.view.tintColor = .black
            alert.addAction(oKaction)
            alert.addAction(noAction)
            self.present(alert, animated: true)
        }.store(in: &cancelable)
    }
    
    func myProfile() {
        viewModel.dataSourse.sink { [weak self] user in
            guard let self else { return }
            self.profileUser = user
            self.nameUserTextField.text = user.name
            self.phoneUserTextField.text = user.phone
        }.store(in: &cancelable)
    }
    
}

extension ProfileUserViewController: UITextFieldDelegate, FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    
    func fpnDidValidatePhoneNumber(textField: FlagPhoneNumber.FPNTextField, isValid: Bool) {
        ///
    }
    
    func fpnDisplayCountryList() {
        let navVC  = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        self.present(navVC, animated: true)
    }
    
}

    



