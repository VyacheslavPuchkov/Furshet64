//
//  StackExt.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 18.10.2023.
//

import UIKit

extension UIStackView {
    convenience init(views: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     alignment: Alignment = .center) {
        
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
    }
    
}
