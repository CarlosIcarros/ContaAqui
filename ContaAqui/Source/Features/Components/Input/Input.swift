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
    private var dateFormat: String?
    
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

        let eyeContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24)) 
        togglePasswordButton.frame = CGRect(x: 8, y: 0, width: 24, height: 24)
        eyeContainer.addSubview(togglePasswordButton)

        textField.rightView = eyeContainer
        textField.rightViewMode = .always
       setupView()
    }
    
    init(placeHolder: String, iconName: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolder

        // Detectar se é campo de data pelo ícone e placeholder
        if iconName == "calendar" {
            if placeHolder.count == 7 { // "00/0000"
                dateFormat = "##/####"
            } else { 
                dateFormat = "##/##/####"
            }
        }

        let iconImageView = UIImageView(image: UIImage(systemName: iconName))
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit

        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        iconImageView.frame = CGRect(x: 8, y: 2, width: 20, height: 20)
        iconContainer.addSubview(iconImageView)

        textField.leftView = iconContainer
        textField.leftViewMode = .always

        setupView()
    }
    
    init(placeHolder: String, textLeft: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeHolder

        let label = UILabel()
        label.text = textLeft
        label.font = Text.buttonSm
        label.numberOfLines = 1 
        label.sizeToFit()
        label.tintColor = Colors.gray600

        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: label.frame.width + 16, height: 24))
        label.frame = CGRect(x: 8, y: 2, width: label.frame.width, height: 20)
        iconContainer.addSubview(label)

        textField.leftView = iconContainer
        textField.leftViewMode = .always

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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Aplicar formatação de data se necessário
        if let dateFormat = dateFormat {
            return formatDateInput(textField: textField, range: range, replacementString: string, format: dateFormat)
        }
        
        return true
    }
    
    private func formatDateInput(textField: UITextField, range: NSRange, replacementString string: String, format: String) -> Bool {
        // Permitir apenas números
        if !string.isEmpty && !CharacterSet.decimalDigits.contains(UnicodeScalar(string)!) {
            return false
        }
        
        guard let text = textField.text else { return false }
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        // Remover caracteres não numéricos
        let numbersOnly = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Aplicar máscara baseada no formato
        let formatted = applyMask(to: numbersOnly, format: format)
        
        textField.text = formatted
        
        // Definir posição do cursor
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: formatted.count) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        return false
    }
    
    private func applyMask(to text: String, format: String) -> String {
        var result = ""
        var textIndex = text.startIndex
        
        for char in format {
            if textIndex >= text.endIndex {
                break
            }
            
            if char == "#" {
                result.append(text[textIndex])
                textIndex = text.index(after: textIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9._%+-]+)@(?:[a-zA-Z0-9-]+)\\.(?:[a-zA-Z]{2,})"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
