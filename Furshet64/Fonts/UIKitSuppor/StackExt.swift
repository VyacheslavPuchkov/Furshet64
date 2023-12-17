//
//  StackExt.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 07.06.2023.
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
