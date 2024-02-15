//
//  CodeValidViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.11.2023.
//

import UIKit
import Combine

class CodeValidViewController: BaseViewController {
    
    // MARK: - Constants
    enum Constants {
        static let size = CGSize(width: 350, height: 50)
    }
    
    // MARK: - ViewModel
    var viewModel: CodeValidViewModel = .init(verificId: "", phone: "")
    // MARK: - Combine
    private var cancelable = Set<AnyCancellable>()
    // MARK: - Private variable
    private var textField: UITextField {
        return codeTextField
    }
    
    // MARK: - UI
    var codeTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.textColor = .systemGreen
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.font = .bodyLarge2
        textField.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        textField.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Проверить код", for: .normal)
        button.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: Constants.size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.size.height).isActive = true
        button.layer.cornerRadius = 6
        button.alpha = 0.5
        button.isEnabled = false
        button.addTarget(self, action: #selector(showCodeValid), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.verificCode)
        configure()
        setupTextView()
        receivingAlert()
    }
    
    // MARK: - Func
    
    @objc func textFieldAction(sender: UITextView) {
        switch sender {
        case codeTextField:
            viewModel.verificCode = sender.text ?? ""
        default: break
        }
    }
    
    @objc func showCodeValid() {
        viewModel.showCodeValid()
    }
    
}

// MARK: - Private func
private extension CodeValidViewController {
   
    func setupTextView() {
        codeTextField.delegate = self
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
    }
    
    // MARK: - Constraints
    func configure() {
        let stack = UIStackView(views: [codeTextField, sendButton], axis: .vertical, spacing: 35)
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
    }
    
    // MARK: - Combine
    func receivingAlert() {
        viewModel.alertSucceessTrigger.sink { [weak self] () in
            guard let self else { return }
            self.alertChange(titleAlertTwo: "Спасибо за авторизацию", messageAlert:  nil) { _ in
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.tabBarController?.selectedIndex = 2
            } comletionNo: { _ in
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.tabBarController?.selectedIndex = 3
            }
        }.store(in: &cancelable)
    }
    
}


// MARK: - UITextFieldDelegate
extension CodeValidViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLenght = currentCharacterCount + string.count - range.length
        return newLenght <= 6
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 6 {
            sendButton.alpha = 1
            sendButton.isEnabled = true
        } else {
            sendButton.alpha = 0.5
            sendButton.isEnabled = false
        }
    }
    
}
