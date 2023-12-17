//
//  AuthViewModel.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 25.11.2023.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber
import Combine

class AuthViewModel: NSObject {
   
    var profileUser: ProfileUser = .init(id: UUID().uuidString, name: "", phone: "")
    var authSuccessTrigger = PassthroughSubject<String?, Never>()

    override init() {
        super.init()
    }
    
    func singUpPhone() {
        PhoneAuthProvider.provider().verifyPhoneNumber(profileUser.phone, uiDelegate: nil) { [weak self] (verificationID, error) in
            guard let self else { return }
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.authSuccessTrigger.send(verificationID)
                print(verificationID ?? "")
            }
        }
    }
    
}
