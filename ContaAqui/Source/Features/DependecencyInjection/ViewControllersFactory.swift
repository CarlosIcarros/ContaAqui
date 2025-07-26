//
//  ViewControllersFactory.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController {
        let contentView = LoginView()
        let viewController = LoginViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeSpashViewController(flowDelegate: SpashFlowDelegate) -> SpashViewController {
        let contentView = SpashView()
        let viewController = SpashViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makePurchaseviewController(flowDelegate: PurchaseMonthsFlowDelegate) -> PurchaseMonthsViewController {
        let contentView = PurchaseMonthsView()
        let viewController = PurchaseMonthsViewController(contentView: contentView, flowDelegate: flowDelegate)
        
        return viewController
    }

}
