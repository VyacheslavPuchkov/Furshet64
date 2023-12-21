//
//  EntranceViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 14.11.2023.
//

import Foundation
import Combine

class EntranceViewModel: NSObject {
    
    // MARK: - Variable
    var userEntrance: EntranceModel = .init(password: "", email: "")
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Func
    func signIn() {
        AuthService.shared.signInEmail(email: userEntrance.email, password: userEntrance.password) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
