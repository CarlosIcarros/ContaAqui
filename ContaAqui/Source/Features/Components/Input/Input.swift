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
    private var isShowPassword: Bool = false
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolder
        
        if placeHolder.lowercased().contains("e-mail") {
            isEmailField = true
        }
        
       setupView()
    }
    
    init(passwordLabel: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = passwordLabel
        textField.isSecureTextEntry = true
        
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        // Criar uma view que vai envolver o botão e dar padding
        let eyeContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24)) // largura maior que o botão
        togglePasswordButton.frame = CGRect(x: 8, y: 0, width: 24, height: 24) // padding de 8 à esquerda
        eyeContainer.addSubview(togglePasswordButton)

        // Adicionar ao textField
        textField.rightView = eyeContainer
        textField.rightViewMode = .always
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
    
    private let togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "eye.fill") // ícone do SF Symbols
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: -20, y: 0, width: 20, height: 20)
        return button
    }()
    
    @objc
    private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        
        let imageName = textField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        togglePasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
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
