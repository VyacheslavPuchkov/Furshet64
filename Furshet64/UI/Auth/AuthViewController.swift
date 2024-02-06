//
//  AuthViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 23.11.2023.
//

import UIKit
import Combine
import FlagPhoneNumber
import FirebaseAuth

class AuthViewController: BaseViewController {
    
    // MARK: - Constants
    enum Constants {
        static let size = CGSize(width: 350, height: 50)
    }
    
    // MARK: - ViewModel
    var viewModel: AuthViewModel = .init()
    // MARK: - Private variable
    private var listController: FPNCountryListViewController!
    private var cancelable = Set<AnyCancellable>()
    private var tField: UITextField {
        return phoneUserTextField
    }
    
    // MARK: - UI
    var phoneUserTextField: FPNTextField = {
        let textField: FPNTextField = FPNTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "  Ваш номер", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        textField.widthAnchor.constraint(equalToConstant: Constants.size.width
        ).isActive = true
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var authButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Получить код", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var authEmailButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Авторизоваться с помощью e-mail", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionButtonTwo), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupTextField()
        setupConfig()
        bind()
        print(Auth.auth().currentUser?.uid ?? "no id")
    }
    
    // MARK: - Func
    @objc func actionButton() {
        viewModel.singUpPhone()
    }
    
    @objc func actionButtonTwo() {
        let vc = EntranceUserViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldAction(sender: FPNTextField) {
        switch sender {
        case phoneUserTextField:
            viewModel.profileUser.phone = (sender.selectedCountry?.phoneCode ?? "") + (sender.text ?? "")
        default: break
        }
    }
    
}

// MARK: - Private func
private extension AuthViewController {
    
    func setupTextField() {
        tField.delegate = self
        tField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
    }
    
    func setupConfig() {
        authButton.alpha = 0.6
        authButton.isEnabled = false
        
        phoneUserTextField.displayMode = .list
        phoneUserTextField.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController.setup(repository: phoneUserTextField.countryRepository)
        
        listController?.didSelect = { [weak self] country in
            guard let self else { return }
            self.phoneUserTextField.setFlag(countryCode: country.code)
        }
    }
    
    // MARK: - Constraints
    func setConstraint() {
        let stack = UIStackView(views: [authButton, authEmailButton], axis: .vertical, spacing: 16)
        let finalStack = UIStackView(views: [phoneUserTextField, stack], axis: .vertical, spacing: 45)
        view.addSubview(finalStack)
        finalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finalStack.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
    }
    
    // MARK: - Combine
    func bind() {
        viewModel.authSuccessTrigger.sink(receiveValue: { [weak self] verificID in
            guard let verificID, let phone = self?.phoneUserTextField.text else { return }
            let vc = CodeValidViewController()
            vc.viewModel = .init(verificId: verificID, phone: phone)
            self?.navigationController?.pushViewController(vc, animated: true)
        }).store(in: &cancelable)
    }
    
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate, FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    
    func fpnDidValidatePhoneNumber(textField: FlagPhoneNumber.FPNTextField, isValid: Bool) {
        if isValid {
            authButton.alpha = 1
            authButton.isEnabled = true
            
            viewModel.profileUser.phone = textField.getFormattedPhoneNumber(format: .International)!
        } else {
            authButton.alpha = 0.6
            authButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navVC  = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        phoneUserTextField.text = ""
        self.present(navVC, animated: true)
    }
    
}

