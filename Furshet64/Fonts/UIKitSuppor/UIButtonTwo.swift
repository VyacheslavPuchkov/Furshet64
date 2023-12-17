//
//  UIButtonTwo.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 19.06.2023.
//

import UIKit


extension UIButton {
    convenience init(nameButtonTwo: String) {
        self.init()
        setTitle(nameButtonTwo, for: .normal)
        layer.borderColor = UIColor(named: "grayColor")?.cgColor
        layer.borderWidth = 2
        setTitleColor(UIColor(named: "grayColor"), for: .normal)
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalToConstant: 120).isActive = true
        layer.cornerRadius = 6
    }
}
