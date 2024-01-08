//
//  CodeValidVM.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 26.11.2023.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber
import Combine

class CodeValidViewModel: NSObject {
    
    // MARK: - Variable
    var profileUser: ProfileUser = .init(id: UUID().uuidString, name: "", phone: "")
    var verificCode: String = ""
    var verificId: String
    // MARK: - Combine
    var alertSucceessTrigger = PassthroughSubject<UIAlertController, Never>()
    
    // MARK: - Init
    init(verificId: String, phone: String) {
        self.verificId = verificId
        self.profileUser.phone = phone
        super.init()
    }

    // MARK: - Func
   func showCodeValid() {
        AuthService.shared.signUpPhone(verificationID: verificId, verificationCode: verificCode) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.profileUser.id = user.uid
                self.alertSucceessTrigger.send(UIAlertController(title: "Спасибо за регистрацию", message: "Заполните пожалуйста ваш профиль", preferredStyle: .alert))
                self.setProfile()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Private func
    func setProfile() {
        DatabaseService.shared.setProfile(user: profileUser) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success( _):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
