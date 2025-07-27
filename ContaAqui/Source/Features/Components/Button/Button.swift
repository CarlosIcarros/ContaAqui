//
//  Button.swift
//  ContaAqui
//
//  Created by Carlos Silva on 26/07/25.
//

import Foundation
import UIKit

class Button: UIView {
    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = Colors.magenta
        button.layer.cornerRadius = 8
        button.titleLabel?.font = Text.buttonMd
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private func setupView() {
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
