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
    private var isSelectedState: Bool = false
    
    init(status: Status, title: String) {
        self.status = status
        self.title = title
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.setTitle(title, for: .normal)
        
        let icon = status == .positive ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"
        let image = UIImage(systemName: icon)?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .medium))
        button.setImage(image, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Configura o estado inicial
        updateButtonAppearance()
    }
    
    private func updateButtonAppearance() {
        if isSelectedState {
            // Estado selecionado - mais escuro
            switch status {
            case .positive:
                button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
                button.setTitleColor(.white, for: .normal)
                button.tintColor = .white
                button.layer.borderColor = UIColor.systemGreen.cgColor
            case .negative:
                button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.8)
                button.setTitleColor(.white, for: .normal)
                button.tintColor = .white
                button.layer.borderColor = UIColor.systemRed.cgColor
            }
        } else {
            // Estado normal - mais claro
            switch status {
            case .positive:
                button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
                button.setTitleColor(.systemGreen, for: .normal)
                button.tintColor = .systemGreen
                button.layer.borderColor = UIColor.systemGreen.cgColor
            case .negative:
                button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
                button.setTitleColor(.systemRed, for: .normal)
                button.tintColor = .systemRed
                button.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
    }
    
    // MARK: - Public Methods
    func setSelected(_ selected: Bool) {
        isSelectedState = selected
        updateButtonAppearance()
    }
    
    func isSelected() -> Bool {
        return isSelectedState
    }
}
