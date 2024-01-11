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
    
    // MARK: - Combine
    var succeessTrigger = PassthroughSubject<Void, Never>()
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Func
    func signIn() {
        AuthService.shared.signInEmail(email: userEntrance.email, password: userEntrance.password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.succeessTrigger.send()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
