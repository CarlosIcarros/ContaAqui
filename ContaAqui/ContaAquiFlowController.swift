//
//  ContaAquiFlowController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation
import UIKit

class ContaAquiFlowController {
    private var navigationController: UINavigationController?
    private var viewControllerFactory: ViewControllersFactoryProtocol
    
    public init() {
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    func start() -> UINavigationController? {
        let startViewController  = viewControllerFactory.makeSpashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}




extension ContaAquiFlowController: SpashFlowDelegate {
    func navigateToLogin() {
        let viewController = viewControllerFactory.makeLoginViewController(flowDelegate: self)
        self.navigationController?.setViewControllers([viewController], animated: true)
    }
}


extension ContaAquiFlowController: LoginFlowDelegate {
    func navigateToHome() {
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        
        self.navigationController?.setViewControllers([viewController], animated: true)
    }
}

extension ContaAquiFlowController: HomeFlowDelegate {
    func logout() {
        let viewController = viewControllerFactory.makeLoginViewController(flowDelegate: self)
        self.navigationController?.setViewControllers([viewController], animated: true)
    }
    
    
}
