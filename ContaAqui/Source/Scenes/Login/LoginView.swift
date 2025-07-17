//
//  LoginView.swift
//  ContaAqui
//
//  Created by Carlos Silva on 17/07/25.
//

import Foundation
import UIKit

class LoginView: UIView {
    public var delegate: LoginFlowDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let background: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Text.titleSmBold
        label.text = "BOAS VINDAS!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let titleDescription: UILabel = {
        let label = UILabel()
        label.font = Text.textSm
        label.text = "Pronto para organizar suas finanças? Acesse agora"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: Input = {
        let textField = Input(placeHolder: "Nome")
      
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let emailTextField: Input = {
        let textField = Input(placeHolder: "E-mail")
      
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let passwordTextField: Input = {
        let textField = Input(passwordLabel: "Senha")
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = Colors.gray300
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        return divider
    }()
    
    private let loginButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Entrar", for: .normal)
        button.backgroundColor = Colors.magenta
           button.layer.cornerRadius = 8
           button.titleLabel?.font = Text.buttonMd
           button.tintColor = .white
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(background)
    
        background.addSubview(backgroundImage)
        background.addSubview(titleLabel)
        background.addSubview(titleDescription)
        background.addSubview(nameTextField)
        background.addSubview(emailTextField)
        background.addSubview(passwordTextField)
        background.addSubview(divider)
        background.addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView ocupa toda a tela
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

                background.topAnchor.constraint(equalTo: scrollView.topAnchor),
                background.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                background.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                background.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

                background.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // 🔥 Ponto-chave!

            // Conteúdo
            backgroundImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 24),
            backgroundImage.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 24),
            backgroundImage.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -24),
            backgroundImage.heightAnchor.constraint(equalToConstant: 366),

            titleLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 24),

            titleDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleDescription.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 24),

            nameTextField.topAnchor.constraint(equalTo: titleDescription.bottomAnchor, constant: 28),
            nameTextField.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),

            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 22),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 22),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),

            divider.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            divider.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),

            loginButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            loginButton.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -24)

        ])
    }

    
}
