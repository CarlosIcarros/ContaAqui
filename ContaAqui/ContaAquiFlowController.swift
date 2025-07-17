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
    func navigateToHome() {
        let viewController = viewControllerFactory.makeLoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
