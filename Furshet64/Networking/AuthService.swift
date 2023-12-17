//
//  AuthService.swift
//  Furshet64
//
//  Created by Вячеслав Пучков on 05.11.2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    private init() { }
    private let auth = Auth.auth()
    
    var currentUser: User? { auth.currentUser }
    
    func signUpEmail(email: String, password: String, completion: @escaping(Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error ))
            }
        }
    }
    
    func signUpPhone(verificationID: String, verificationCode: String, completion: @escaping(Result<User, Error>) -> ()){
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        auth.signIn(with: credetional) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signInEmail (email: String, password: String, completion: @escaping(Result<User, Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
}
