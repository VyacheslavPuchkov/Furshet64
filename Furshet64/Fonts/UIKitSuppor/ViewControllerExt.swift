//
//  ViewControllerExt.swift
//  as_nail._
//
//  Created by Вячеслав Пучков on 18.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertChange(titleAlert: String, messageAlert: String, completion: ((UIAlertAction) -> Void)?, comletionNo: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: titleAlert,
                                      message: messageAlert,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Авторизация", style: .default, handler: completion)
        let noAction = UIAlertAction(title: "Без изменений", style: .default, handler: comletionNo)
        alert.addAction(okAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
        return
    }
    
    func alertChange(titleAlert: String, messageAlert: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: titleAlert,
                                      message: messageAlert,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: completion)
        alert.addAction(okAction)
        self.present(alert, animated: true)
        return
    }
    func alertChange(titleAlertTwo: String, messageAlert: String, completion: ((UIAlertAction) -> Void)?, comletionNo: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: titleAlertTwo,
                                      message: messageAlert,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default, handler: completion)
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: comletionNo)
        alert.addAction(okAction)
        alert.addAction(noAction)
        self.present(alert, animated: true)
        return
    }
}
