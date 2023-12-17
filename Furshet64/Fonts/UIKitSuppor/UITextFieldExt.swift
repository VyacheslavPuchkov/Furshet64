//
//  UITextExt.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 21.06.2023.
//

import Foundation
import UIKit

extension UITextField {
    convenience init(placeholderText: String) {
        self.init()
        placeholder = placeholderText
        attributedPlaceholder = NSAttributedString(string: "\(placeholderText)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grayColor") ?? .white])
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor = .black
        textColor = .white
        textAlignment = .left
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10
        }
}
extension UITextField {
    convenience init(placeholderTextOne: String) {
        self.init()
        placeholder = placeholderTextOne
        attributedPlaceholder = NSAttributedString(string: "\(placeholderTextOne)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grayColor") ?? .white])
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor = .black
        textColor = .white
        textAlignment = .center
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10
    }
}

extension UITextField {
    convenience init(placeholderTextTwo: String) {
        self.init()
        placeholder = placeholderTextTwo
        attributedPlaceholder = NSAttributedString(string: "\(placeholderTextTwo)", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "grayColor") ?? .white])
        backgroundColor = .clear
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftViewMode = .always
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "grayColor")?.cgColor
        textColor = .white
        textAlignment = .left
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10
    }
}

extension UITextField {
private func setPasswordToggleImage(_ button: UIButton) {
    if(isSecureTextEntry){
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = UIColor(named: "grayColor")
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

