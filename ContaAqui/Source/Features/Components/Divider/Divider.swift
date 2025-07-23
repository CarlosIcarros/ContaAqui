//
//  Divider.swift
//  ContaAqui
//
//  Created by Carlos Silva on 20/07/25.
//

import Foundation
import UIKit

class Divider: UIView {
    let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = Colors.gray300
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        return divider
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(divider)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: self.topAnchor),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
