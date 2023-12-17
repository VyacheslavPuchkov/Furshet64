//
//  AuthorizationViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 26.10.2023.
//

import UIKit
import Combine

class RegistrationUserViewController: BaseViewController {
    
    var viewModel: RegistrationViewModel = .init()
    private var cancelable = Set<AnyCancellable>()
    
    private var textField: [UITextField] {
        return [mailUserTextField, passwordUserTextField, passwordTwoUserTextField]
    }
    
    var registrationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Регистрация"
        label.textAlignment = .center
        label.font = .defaultLargeTitleBold
        label.textColor = .white
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
        button.backgroundColor = .white.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(entranceActionButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        setupTextField()
        bind()
    }
    
    @objc func entranceActionButton() {
       let vc = EntranceUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionButton() {
        viewModel.signUp()
        viewModel.setProfile()
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
    
    private func setupTextField() {
        textField.forEach { textField in
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        }
    }
    
    private func bind() {
        viewModel.alertSucceessTrigger.sink(receiveValue: { alert in
            let action = UIAlertAction(title: "К профилю", style: .default) { _ in
                self.navigationController?.tabBarController?.selectedIndex = 2
            }
            alert.addAction(action)
            self.present(alert, animated: true)
         }).store(in: &cancelable)
    }
    
    private func setConstraint() {
        let stack = UIStackView(views: [mailUserTextField, passwordUserTextField, passwordTwoUserTextField], axis: .vertical, spacing: 10)
        let stackButton = UIStackView(views: [registrationButton, entranceButton], axis: .vertical, spacing: 10)
        let stackFinal = UIStackView(views: [registrationLabel, stack, stackButton], axis: .vertical, spacing: 30)
        view.addSubview(stackFinal)
        stackFinal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackFinal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackFinal.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
    }
    
}

extension RegistrationUserViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return true
    }
    
}
