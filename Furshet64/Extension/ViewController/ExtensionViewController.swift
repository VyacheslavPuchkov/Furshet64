//
//  ExtensionViewController.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 22.10.2023.
//

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
        alert.view.tintColor = .black
        self.present(alert, animated: true)
        return
    }
    
    func alertChange(titleAlert: String, messageAlert: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: titleAlert,
                                      message: messageAlert,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Спасибо", style: .default, handler: completion)
        alert.addAction(okAction)
        alert.view.tintColor = .black
        self.present(alert, animated: true)
        return
    }
    func alertChange(titleAlertTwo: String, messageAlert: String?, completion: ((UIAlertAction) -> Void)?, comletionNo: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: titleAlertTwo,
                                      message: messageAlert,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "К профилю", style: .default, handler: completion)
        let noAction = UIAlertAction(title: "В корзину", style: .default, handler: comletionNo)
        alert.addAction(okAction)
        alert.addAction(noAction)
        alert.view.tintColor = .black
        self.present(alert, animated: true)
        return
    }
    
}
