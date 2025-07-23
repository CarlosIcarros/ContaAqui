//
//  LoginViewDelegate.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func sendLoginData(name: String, email: String, password: String)
}
