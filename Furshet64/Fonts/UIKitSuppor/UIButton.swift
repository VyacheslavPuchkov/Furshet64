//
//  UIButton.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 07.06.2023.
//


import UIKit

extension UIButton {
    convenience init(nameButton: String) {
        self.init()
        setTitle(nameButton, for: .normal)
        backgroundColor = UIColor(named: "darkGrayColor")?.withAlphaComponent(0.7)
        setTitleColor(UIColor(named: "grayColor"), for: .normal)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        layer.cornerRadius = 10
    }
}

extension UIButton {
    convenience init(cornerRadius: Int) {
        self.init()
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "grayColor")?.cgColor
        setTitleColor(UIColor(named: "grayColor"), for: .normal)
        heightAnchor.constraint(equalToConstant: 20).isActive = true
        widthAnchor.constraint(equalToConstant: 150).isActive = true
        layer.cornerRadius = CGFloat(cornerRadius)
    }
}




