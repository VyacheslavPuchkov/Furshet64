//
//  EntranceUserViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 26.10.2023.
//

import UIKit
import Combine

class EntranceUserViewController: BaseViewController {
    
    // MARK: - ViewModel
    var viewModel: EntranceViewModel = .init()
    
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    
    // MARK: - Private variable
    private var arrayTF: Array<UITextField> {
        return [mailUserTextField, passwordUserTextField]
    }

    // MARK: - UI
    var authorizationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Авторизация"
        label.textAlignment = .center
        label.font = .defaultLargeTitleBold
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    var mailUserTextField = UITextField(placeholderText: "Почта")
    var passwordUserTextField = UITextField(placeholderTextSecure: "Пароль")
    
    lazy var entranceButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var registrationButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Нет аккаунта?", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(registrationActionButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var authPhoneButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Авторизоваться с помощью телефона", for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(actionButtonTwo), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupTextField()
        bind()
    }
    
    // MARK: - Func
    @objc func actionButton() {
        viewModel.signIn()
    }
    
    @objc func registrationActionButton() {
        let vc = RegistrationUserViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionButtonTwo() {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldAction(sender: UITextField) {
        switch sender {
        case mailUserTextField:
            viewModel.userEntrance.email = sender.text ?? ""
        case passwordUserTextField:
            viewModel.userEntrance.password = sender.text ?? ""
        default: break
        }
    }
    
}

// MARK: - Private func
private extension EntranceUserViewController {
    
    func setupTextField() {
        arrayTF.forEach { textField in
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        }
    }
    
    // MARK: - Constraints
    func setConstraint() {
        let stack = UIStackView(views: [mailUserTextField, passwordUserTextField], axis: .vertical, spacing: 10)
        let stackButton = UIStackView(views: [entranceButton, registrationButton, authPhoneButton], axis: .vertical, spacing: 10)
        let stackFinal = UIStackView(views: [authorizationLabel, stack, stackButton], axis: .vertical, spacing: 45)
        view.addSubview(stackFinal)
        stackFinal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackFinal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackFinal.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
    }
    
    // MARK: - Combine
    func bind() {
        viewModel.succeessTrigger.sink { [weak self] () in
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

    
}

// MARK: - UITextFieldDelegate
extension EntranceUserViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return true
    }
    
}



