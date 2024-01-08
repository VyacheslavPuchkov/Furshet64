//
//  StringExt.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 08.01.2024.
//

import Foundation
import UIKit

extension String {
    
    func widthOfString(uisingFont font: UIFont) -> CGFloat {
        let fontAttributed = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributed)
        
        return ceil(size.width)
    }
    
}
