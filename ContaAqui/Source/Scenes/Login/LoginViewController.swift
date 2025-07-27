//
//  LoginViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 17/07/25.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    let viewModel = LoginViewModel()
    let contentView: LoginView
    weak var flowDelegate: LoginFlowDelegate?
    
    init(contentView: LoginView, flowDelegate: LoginFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        gestureFunction()
        didTapLoginButton()
    }
    
    private func gestureFunction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // permite que outros toques continuem funcionando
        view.addGestureRecognizer(tapGesture)
    }
    
    private func didTapLoginButton() {
        contentView.loginButton.button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTapped() {
        let name = contentView.nameTextField.textField.text ?? ""
        let email = contentView.emailTextField.textField.text ?? ""
        let password = contentView.passwordTextField.textField.text ?? ""
        
        contentView.delegate?.sendLoginData(name: name, email: email, password: password)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setup() {
        view.addSubview(contentView)
        contentView.delegate = self
        setupConstraints()
        bindViewModel()
    }
    
    private func setupConstraints() {
       contentView.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           contentView.topAnchor.constraint(equalTo: view.topAnchor),
           contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
       ])
    }
    
    private func bindViewModel () {
        viewModel.successResult = { [weak self] usernameLogin in
            self?.presentSaveLoginAlert(email: usernameLogin)
        }
        
        viewModel.errorResult = { [weak self] errorMessage in
            self?.presentErrorAlert(message: errorMessage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Erro ao logar", message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Tentar novamente", style: .default)
        
        alertController.addAction(retryAction)
        
        self.present(alertController, animated: true)
    }
    
    private func presentSaveLoginAlert(email: String) {
        let alertController = UIAlertController(title: "Salvar Acesso", message: "Deseja salvar seu acesso?", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Salvar", style: .default) { _ in
            let name = self.contentView.nameTextField.textField.text ?? ""
        self.askEnabledFaceID(email: email, name: name)
        }
        
        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { _ in
            self.flowDelegate?.navigateToHome()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func askEnabledFaceID(email: String, name: String) {
           let context = LAContext()
           var error: NSError?
           
           let supportsBiometry = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
           if supportsBiometry {
               let alert = UIAlertController(title: "habilitar o face ide", message: "deseja habilitar o login por biometria?", preferredStyle: .alert)
               let yesAction = UIAlertAction(title: "Sim", style: .default) { _ in
                   let user = User(email: email, name: name, hasFaceIdEnabled: true)
                   UserDefaultsManager.saveUser(user: user)
                   self.flowDelegate?.navigateToHome()
               }
               
               let noAction = UIAlertAction(title: "Não", style: .cancel) { _ in
                   let user = User(email: email, name: name, hasFaceIdEnabled: false)
                   UserDefaultsManager.saveUser(user: user)
                   self.flowDelegate?.navigateToHome()
               }
               
               alert.addAction(yesAction)
               alert.addAction(noAction)
               self.present(alert, animated: true)
           } else {
               let user = User(email: email, name: name, hasFaceIdEnabled: false)
               UserDefaultsManager.saveUser(user: user)
               self.flowDelegate?.navigateToHome()
           }
       }
}


extension LoginViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        contentView.scrollView.contentInset.bottom = keyboardFrame.height + 20
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        contentView.scrollView.contentInset.bottom = 0
    }

}

extension LoginViewController: LoginViewDelegate {
    func sendLoginData(name: String, email: String, password: String) {
        viewModel.doAuth(email: email, password: password)
    }
}


