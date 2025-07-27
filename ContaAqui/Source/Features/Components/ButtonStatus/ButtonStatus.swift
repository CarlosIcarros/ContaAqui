//
//  ButtonStatus.swift
//  ContaAqui
//
//  Created by Carlos Silva on 26/07/25.
//

import Foundation
import UIKit

enum Status {
    case positive
    case negative
}

class ButtonStatus: UIView {
    private let status: Status
    private let title: String
    init(status: Status, title: String) {
        self.status = status
        self.title = title
      
        super.init(frame: .zero)
        
        setupView()
    }
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let color = status == .positive ? Colors.green : Colors.red
        let icon = status == .positive ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
        let image = UIImage(systemName: icon)? .withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .medium))
        
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
        button.backgroundColor = color.withAlphaComponent(0.2)
        button.tintColor = color
        button.setTitle(title, for: .normal)
        
        button.setImage(image, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
         addSubview(button)
         button.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             button.topAnchor.constraint(equalTo: topAnchor),
             button.leadingAnchor.constraint(equalTo: leadingAnchor),
             button.trailingAnchor.constraint(equalTo: trailingAnchor),
             button.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
     }
}
