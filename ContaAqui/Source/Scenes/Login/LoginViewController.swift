//
//  LoginViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 17/07/25.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let contentView: LoginView
    weak var flowDelegate: LoginFlowDelegate?
    
    init(contentView: LoginView, flowDelegate: LoginFlowDelegate?) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      setup()
        
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // permite que outros toques continuem funcionando
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setup() {
            view.addSubview(contentView)
        
            setupConstraints()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
