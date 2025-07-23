//
//  SpashViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation
import UIKit
import LocalAuthentication

class SpashViewController: UIViewController {
    let contentView: SpashView
    public weak var flowDelegate: SpashFlowDelegate?
    
    init(contentView: SpashView,flowDelegate: SpashFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        animateShow()
    }
    
    private func decideNavigationFlow() {
        if let user = UserDefaultsManager.loadUser() {
            if user.hasFaceIdEnabled {
                authenticatedWithFaceID()
            } else {
                flowDelegate?.navigateToHome()
            }
        } else {
            self.flowDelegate?.navigateToLogin()
        }
    }
    
    private func setupView() {
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.isHidden = true
        setGradientBackground(view: self.view)
        setupConstraints()
    }
    
    private func setGradientBackground(view: UIView) {
        let colorTop =  Colors.gray700.cgColor
        let colorBottom = Colors.gray600.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        // Set diagonal gradient from top-left to bottom-right
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = view.bounds
                
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}


extension SpashViewController {
    private func animateShow() {
        self.contentView.logoImageView.alpha = 0
        self.contentView.logoImageView.transform = CGAffineTransform(translationX: 0, y: 0)
        self.contentView.logoImageView.isHidden = false

        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.contentView.logoImageView.alpha = 1.0 // Fade-in
        }, completion: { [self] _ in
                animateUp()
            }
        )
    }
    
    private func animateUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseInOut],animations: {
            self.contentView.logoImageView.transform = CGAffineTransform(translationX: 0, y: -200)
        }, completion: {_ in 
            self.decideNavigationFlow()
        })
    }
}

// MARK: face id c onfiguration
extension SpashViewController {
    private func authenticatedWithFaceID() {
        let context = LAContext()
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            let reason = "Autentique-se para acessar o app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                DispatchQueue.main.async {
                    if success {
                        self.flowDelegate?.navigateToHome()
                    } else {
                        self.flowDelegate?.navigateToLogin()
                    }
                }
            }
        } else {
            self.flowDelegate?.navigateToLogin()
        }
    }
}
