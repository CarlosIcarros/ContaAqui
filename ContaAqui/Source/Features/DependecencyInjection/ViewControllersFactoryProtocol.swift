//
//  ViewControllersFactory.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSpashViewController(flowDelegate: SpashFlowDelegate) -> SpashViewController
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
    func makePurchaseviewController(flowDelegate: PurchaseMonthsFlowDelegate) -> PurchaseMonthsViewController
}
