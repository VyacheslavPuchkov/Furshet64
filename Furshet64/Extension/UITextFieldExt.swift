//
//  UITextFieldExt.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 26.10.2023.
//

import UIKit
import FlagPhoneNumber

extension UITextField {
    convenience init(placeholderTextOne: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        placeholder = placeholderTextOne
        attributedPlaceholder = NSAttributedString(string: "\(placeholderTextOne)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGreen.cgColor
        textColor = .systemGreen
        isEnabled = false
        textAlignment = .left
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10

        }
    
    convenience init(placeholderText: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        placeholder = placeholderText
        attributedPlaceholder = NSAttributedString(string: "\(placeholderText)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGreen.cgColor
        textColor = .systemGreen
        textAlignment = .left
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10

        }
    
    convenience init(placeholderTextSecure: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        placeholder = placeholderTextSecure
        attributedPlaceholder = NSAttributedString(string: "\(placeholderTextSecure)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGreen.cgColor
        textColor = .systemGreen
        textAlignment = .left
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10
        isSecureTextEntry = true
        enablePasswordToggle()
    }
    
    private func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            button.tintColor = .systemGreen
        }else{
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            
        }
    }

    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
        
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        setPasswordToggleImage(sender as! UIButton)
    }
    
}






