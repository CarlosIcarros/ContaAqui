//
//  ViewControllersFactory.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeLoginViewController() -> LoginViewController {
        let contentView = LoginView()
        let viewController = LoginViewController(contentView: contentView, flowDelegate: nil)
        return viewController
    }
    
    func makeSpashViewController(flowDelegate: SpashFlowDelegate) -> SpashViewController {
        let contentView = SpashView()
        let viewController = SpashViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
}
