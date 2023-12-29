//
//  RFontStyle.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 18.10.2023.
//

import UIKit

enum RFontStyle: String, CaseIterable {
    case mobileH3
    case mobileH4
    case mobileH5
    case mobileH6
    case bodySmall
    case bodyMedium
    case buttonLarge
    case defaultLargeTitleBold
    case bodyLarge
    case bodyLarge2
    case bodyLarge3
    case labelText
    case bodySmallCaption
    case mobileH2
    case phoneConfirmationTextFieldFont
    case buttonSmall
}

fileprivate let MyriadProBoldSemiExt = "MyriadPro-BoldSemiExt"
fileprivate let SfProTextRegular = "SFProText-Regular"
fileprivate let SfProTextSemibold = "SFProText-Semibold"
fileprivate let SFProDisplayBold = "SFProDisplay-Bold"

extension UIFont {
    static func font(named name: RFontStyle) -> UIFont {
        switch name {
        case .mobileH2:
            return .mobileH2
        case .mobileH3:
            return .mobileH3
        case .mobileH4:
            return .mobileH4
        case .mobileH6:
            return .mobileH6
        case .bodySmall:
            return .bodySmall
        case .bodyMedium:
            return .bodyMedium
        case .buttonLarge:
            return .buttonLarge
        case .bodyLarge2:
            return .bodyLarge2
        case .bodyLarge3:
            return .bodyLarge3
        case .defaultLargeTitleBold:
            return .defaultLargeTitleBold
        case .bodyLarge:
            return .bodyLarge
        case .labelText:
            return .labelText
        case .bodySmallCaption:
            return .bodySmallCaption
        case .mobileH5:
            return .mobileH5
        case .phoneConfirmationTextFieldFont:
            return .phoneConfirmationTextFieldFont
        case .buttonSmall:
            return .buttonSmall
        }
    }
}

extension UIFont {
    static let mobileH1 = UIFont(name: MyriadProBoldSemiExt, size: 45)!
    static let mobileH2 = UIFont(name: MyriadProBoldSemiExt, size: 24)!
    static let mobileH3 = UIFont(name: MyriadProBoldSemiExt, size: 20)!
    static let mobileH4 = UIFont(name: MyriadProBoldSemiExt, size: 19)!
    static let mobileH5 = UIFont(name: MyriadProBoldSemiExt, size: 17)!
    static let mobileH6 = UIFont(name: SfProTextSemibold, size: 14)!
    static let bodySmall = UIFont(name: SfProTextRegular, size: 13)!
    static let bodyMedium = UIFont(name: SfProTextRegular, size: 15)!
    static let bodyLarge = UIFont(name: SfProTextRegular, size: 17)!
    static let bodyLarge2 = UIFont(name: SfProTextRegular, size: 22)!
    static let bodyLarge3 = UIFont(name: SfProTextRegular, size: 20)!
    static let buttonLarge = UIFont(name: SfProTextSemibold, size: 17)!
    static let buttonSmall = UIFont(name: SfProTextSemibold, size: 11)!
    static let defaultLargeTitleBold = UIFont(name: SfProTextSemibold, size: 34)!
    static let labelText = UIFont(name: SfProTextRegular, size: 10)!
    static let bodySmallCaption = UIFont(name: SfProTextRegular, size: 12)!
    static let phoneConfirmationTextFieldFont = UIFont(name: SfProTextSemibold, size: 36)!
}

