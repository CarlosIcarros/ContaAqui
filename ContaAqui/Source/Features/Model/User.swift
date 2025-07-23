//
//  User.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation

struct User: Codable {
    let email: String
    let name: String
    let hasFaceIdEnabled: Bool
}
