//
//  RegistrationViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 09.11.2023.
//

import Foundation
import Combine
import UIKit

class RegistrationViewModel: NSObject {
    
    // MARK: - Variable
    var userRegistration: RegistrationModel = .init(password: "", passwordTwo: "", email: "")
    var userProfile: ProfileUser = .init(id: UUID().uuidString, name: "", phone: "")
    // MARK: - Combine
    var alertSucceessTrigger = PassthroughSubject<UIAlertController, Never>()
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: Func
    func signUp() {
        AuthService.shared.signUpEmail(email: userRegistration.email, password: userRegistration.password) { [weak self] result in
            guard let self, self.userRegistration.password == self.userRegistration.passwordTwo else { return }
            switch result {
            case .success(_):
                self.alertSucceessTrigger.send(UIAlertController(title: "Спасибо за регистрацию", message: "Заполните пожалуйста ваш профиль", preferredStyle: .alert))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile() {
        DatabaseService.shared.setProfile(user: userProfile) { [weak self] result in
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
