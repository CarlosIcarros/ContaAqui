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
    func navigateToPurchase() {
        let viewController = viewControllerFactory.makePurchaseviewController(flowDelegate: self)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func logout() {
        let viewController = viewControllerFactory.makeLoginViewController(flowDelegate: self)
        self.navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func openBottomSheet() {
        let viewController = viewControllerFactory.makeBottomSheetViewController()
        
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        self.navigationController?.present(viewController, animated: true)    }
}

extension ContaAquiFlowController: PurchaseMonthsFlowDelegate {
    func popPage() {
        self.navigationController?.popViewController(animated: true)
    }
}
