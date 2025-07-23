//
//  LoginViewModel.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    func doAuth(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorResult?("Erro ao realizar login \(error)")
            } else {
                self?.successResult?("Deu certo")
            }
            
        }
    }
}
