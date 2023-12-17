//
//  AlertExt.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 17.07.2023.
//

import Foundation
import UIKit

extension UIAlertController {
    func alertChange(titleAlert: String, messageAlert: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: titleAlert,
                                      message: messageAlert,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: completion)
        alert.addAction(okAction)
        self.present(alert, animated: true)
        return
    }
}
