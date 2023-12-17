//
//  UICorol.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

import UIKit

enum RColor: String, CaseIterable {
    case darkRed
    case deepRed
    case red
    case baseBackground
    case borderColorWhenFocused
    case gray4
    case crossButtonEnabled
    case main
    case disabledCross
    case disabledBorder
    case darkGrey
    case lightText
    case grey30
    case grey60
    case searchBarBackground
    case backgroundTFWhenError
    case input
    case customLightGrey
    case buttonFill
    case grabberHandleBackgroundColor
    case separatorColor
    case textLightGrey
    case statusGreen
    case statusGray
}

extension UIColor {
    convenience init?(named: RColor) {
        self.init(named: named.rawValue)
    }
}

extension UIColor {
    static let darkRed = UIColor(named: .darkRed) ?? .red
    static let deepRed = UIColor(named: .deepRed) ?? .red
    static let red = UIColor(named: .red) ?? .red
    static let baseBackground = UIColor(named: .baseBackground) ?? .white
    static let borderColorWhenFocused = UIColor(named: .borderColorWhenFocused) ?? .gray
    static let gray4 = UIColor(named: .gray4) ?? .gray
    static let crossButtonEnabled = UIColor(named: .crossButtonEnabled) ?? .gray
    static let disabledCross = UIColor(named: .disabledCross) ?? .gray
    static let disabledBorder = UIColor(named: .disabledBorder) ?? .gray
    static let main = UIColor(named: .main) ?? .black
    static let lightText = UIColor(named: .lightText) ?? .gray
    static let grey30 = UIColor(named: .grey30) ?? .gray
    static let grey60 = UIColor(named: .grey60) ?? .gray
    static let searchBarBackground = UIColor(named: .searchBarBackground) ?? .gray
    static let backgroundTFWhenError = UIColor(named: .backgroundTFWhenError) ?? .red
    static let input = UIColor(named: .input) ?? .gray
    static let customLightGrey = UIColor(named: .customLightGrey) ?? .lightGray
    static let buttonFill = UIColor(named: .buttonFill) ?? .lightGray
    static let grabberHandleBackgroundColor = UIColor(named: .grabberHandleBackgroundColor) ?? .lightGray
    static let separatorColor = UIColor(named: .separatorColor) ?? .lightGray
    static let textLightGrey = UIColor(named: .textLightGrey) ?? .lightGray
    static let statusGreen = UIColor(named: .statusGreen) ?? .green
    static let statusGray = UIColor(named: .statusGray) ?? .lightGray
}
    

