//
//  AuthorizationViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 26.10.2023.
//

import UIKit
import Combine

class RegistrationUserViewController: BaseViewController {
    
    // MARK: - Constants
    enum Constants {
        static let size = CGSize(width: 350, height: 50)
    }
    
    // MARK: - ViewModel
    var viewModel: RegistrationViewModel = .init()
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    // MARK: - Private variable
    private var textField: [UITextField] {
        return [mailUserTextField, passwordUserTextField, passwordTwoUserTextField]
    }
    
    // MARK: - UI
    var registrationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        label.textAlignment = .center
        label.font = .defaultLargeTitleBold
        label.textColor = .systemGreen
        label.backgroundColor = .clear
        return label
    }()
    
    let mailUserTextField = UITextField(placeholderText: "Почта")
    let passwordUserTextField = UITextField(placeholderTextSecure: "Пароль")
    let passwordTwoUserTextField = UITextField(placeholderTextSecure: "Повторите пароль")
    
    lazy var registrationButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var entranceButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Уже есть аккаунт?", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.systemGreen, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.addTarget(self, action: #selector(entranceActionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var privacyPolicyButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("При входе вы автоматически принимаете политику конфиденциальности", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.addTarget(self, action: #selector(actionButtonThree), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupTextField()
        receivingAlert()
    }
    
    // MARK: - Func
    @objc func entranceActionButton() {
       let vc = EntranceUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionButton() {
        viewModel.signUp()
        viewModel.setProfile()
    }
    
    @objc func actionButtonThree() {
        let vc = PrivacyPolicyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldAction(sender: UITextField) {
        switch sender {
        case mailUserTextField:
            viewModel.userRegistration.email = sender.text ?? ""
        case passwordUserTextField:
            viewModel.userRegistration.password = sender.text ?? ""
        case passwordTwoUserTextField:
            viewModel.userRegistration.passwordTwo = sender.text ?? ""
        default: break
        }
    }
    
}

// MARK: - Private func
private extension RegistrationUserViewController {
    
    func setupTextField() {
        textField.forEach { textField in
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        }
    }
    
    // MARK: - Combine
    func receivingAlert() {
        viewModel.alertSucceessTrigger.sink { [weak self] () in
            guard let self else { return }
            self.alertChange(titleAlertTwo: "Спасибо за регистрацию", messageAlert:  nil) { _ in
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.tabBarController?.selectedIndex = 2
            } comletionNo: { _ in
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.tabBarController?.selectedIndex = 3
            }
        }.store(in: &cancelable)
    }
    
    // MARK: - Constraints
    func configure() {
        let stack = UIStackView(views: [mailUserTextField, passwordUserTextField, passwordTwoUserTextField], axis: .vertical, spacing: 10)
        let stackButton = UIStackView(views: [registrationButton, entranceButton], axis: .vertical, spacing: 10)
        let stackFinal = UIStackView(views: [registrationLabel, stack, stackButton], axis: .vertical, spacing: 30)
        view.addSubview(stackFinal)
        stackFinal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackFinal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackFinal.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
        view.addSubview(privacyPolicyButton)
        NSLayoutConstraint.activate([
            privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyPolicyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension RegistrationUserViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}
