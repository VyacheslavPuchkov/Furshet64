//
//  ProfileUserViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 14.11.2023.
//

import Foundation
import Combine
import FirebaseAuth
import UIKit

class ProfileUserViewModel: NSObject {

    // MARK: - Combine
    var dataSourse = CurrentValueSubject<ProfileUser, Never>(.init(id: "", name: "", phone: ""))
    var alertSucceessTrigger = PassthroughSubject<UIAlertController, Never>()
    
    // MARK: - Init
    override init() {
            super.init()
    }
    
    // MARK: - Func
    func getProfile() {
        DatabaseService.shared.getProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.dataSourse.send(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setProfile(user: ProfileUser) {
        DatabaseService.shared.setProfile(user: user) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func displayView() {
        if Auth.auth().currentUser?.uid != nil {
            getProfile()
        } else {
            self.alertSucceessTrigger.send(UIAlertController(title: "Внимание", message: "Для просмотра своего профиля необходимо авторизоваться", preferredStyle: .alert))
        }
    }
    
    func singOot() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
}

