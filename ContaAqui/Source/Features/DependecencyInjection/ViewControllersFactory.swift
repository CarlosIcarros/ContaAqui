//
//  ViewControllersFactory.swift
//  ContaAqui
//
//  Created by Carlos Silva on 16/07/25.
//

import Foundation

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSpashViewController() -> SpashViewController {
        let contentView = SpashView()
        let viewController = SpashViewController(contentView: contentView)
        return viewController
    }
    
    
}
