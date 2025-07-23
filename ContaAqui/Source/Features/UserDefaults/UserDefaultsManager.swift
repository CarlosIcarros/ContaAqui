//
//  UserDefaultsManager.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation
import UIKit

class UserDefaultsManager {
    public static let userKey = "userKey"
    public static let userName = "userName"
    public static let profileImage = "profileImageKey"
    
    public static func saveUser(user: User) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedData, forKey: userKey)
            UserDefaults.standard.set(user.name, forKey: userName)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static func loadUser() -> User? {
        guard let dataUser = UserDefaults.standard.data(forKey: UserDefaultsManager.userKey) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(User.self, from: dataUser)
    }
    
    public static func loadName() -> String? {
        guard let nameUser = UserDefaults.standard.string(forKey: UserDefaultsManager.userName) else { return nil }
        return nameUser
    }
    
    public static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: userName)
        UserDefaults.standard.synchronize()
    }
    // TODO: precisa rever
    static func loadProfileImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: profileImage) {
            return UIImage(data: imageData)
        }
        
        return UIImage(named: "")
    }
    
    static func saveProfileImage(image: UIImage) {
        if let imageDate = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageDate, forKey: profileImage)
            UserDefaults.standard.synchronize()
        }
    }
}
