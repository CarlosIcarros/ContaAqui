//
//  Input.swift
//  ContaAqui
//
//  Created by Carlos Silva on 17/07/25.
//

import Foundation
import UIKit

class Input: UIView, UITextFieldDelegate {
    private var isEmailField = false
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolder
        
        if placeHolder.lowercased().contains("e-mail") {
            isEmailField = true
        } else {
            print("n foi \(placeHolder.lowercased())")
        }
        
       setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        textField.borderStyle = .none // remove default border
        textField.layer.backgroundColor = Colors.gray200.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = Colors.gray200.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always

        // Se quiser padding também no lado direito:
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        return textField
    }()
    
    private func setupView() {
        textField.delegate = self
        addSubview(textField)
          
        setupConstraints()
      }
      
      private func setupConstraints() {
          NSLayoutConstraint.activate([
              textField.topAnchor.constraint(equalTo: self.topAnchor),
              textField.leadingAnchor.constraint(equalTo: leadingAnchor),
              textField.trailingAnchor.constraint(equalTo: trailingAnchor),
              textField.heightAnchor.constraint(equalToConstant: 56)
          ])
      }
}


extension Input {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.purple.cgColor // borda roxa
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if isEmailField, !isValidEmail(textField.text ?? "") {
            textField.layer.borderColor = UIColor.red.cgColor // ❌ e-mail inválido
        } else {
            textField.layer.borderColor = Colors.gray200.cgColor // ✅ ou padrão
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9._%+-]+)@(?:[a-zA-Z0-9-]+)\\.(?:[a-zA-Z]{2,})"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
