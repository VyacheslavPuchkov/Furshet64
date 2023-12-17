//
//  LabelExt.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 07.06.2023.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(title: String) {
        self.init()
        text = title
        backgroundColor = .clear
        textColor = .black
        textAlignment = .center
        
    }
}
