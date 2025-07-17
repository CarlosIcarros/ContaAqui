//
//  ViewControllersFactory.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSpashViewController(flowDelegate: SpashFlowDelegate) -> SpashViewController
    func makeLoginViewController() -> LoginViewController
}
