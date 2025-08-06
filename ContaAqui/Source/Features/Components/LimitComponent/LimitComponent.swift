//
//  LimitComponent.swift
//  ContaAqui
//
//  Created by Carlos Silva on 20/07/25.
//

import Foundation
import UIKit

class LimitComponent: UIView {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray400
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let textLimit: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(text: String, subText: String, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        textLabel.text = text
        textLabel.textAlignment = alignment
        
        textLimit.text = subText
        textLimit.textAlignment = alignment
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(textLabel)
        addSubview(textLimit)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textLimit.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            textLimit.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLimit.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}
