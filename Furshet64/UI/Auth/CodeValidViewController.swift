//
//  CodeValidViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.11.2023.
//

import UIKit
import Combine

class CodeValidViewController: BaseViewController {
    
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
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .black
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.font = .bodyLarge2
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle("Проверить код", for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.8)
        button.titleLabel?.font = .bodyLarge2
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        setConstraint()
        setupTextView()
        bind()
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
    func setConstraint() {
        let stack = UIStackView(views: [codeTextField, sendButton], axis: .vertical, spacing: 35)
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo:view.centerYAnchor)
        ])
    }
    
    // MARK: - Combine
    func bind() {
        viewModel.alertSucceessTrigger.sink { alert in
            let action = UIAlertAction(title: "К профилю", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.tabBarController?.selectedIndex = 2
            }
            let actionTwo = UIAlertAction(title: "В корзину", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.tabBarController?.selectedIndex = 3
            }
            alert.view.tintColor = .black
            alert.addAction(action)
            alert.addAction(actionTwo)
            self.present(alert, animated: true)
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
