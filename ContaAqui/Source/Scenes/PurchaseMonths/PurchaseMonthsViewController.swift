//
//  PurchaseMonthsViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 23/07/25.
//

import Foundation
import UIKit

class PurchaseMonthsViewController: UIViewController {
    let contentView: PurchaseMonthsView
    weak var flowDelegate: PurchaseMonthsFlowDelegate?
    
    init(contentView: PurchaseMonthsView, flowDelegate: PurchaseMonthsFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configButton()
    }
    
    private func configButton() {
        self.contentView.backButton.addTarget(self, action: #selector(popPage), for: .touchUpInside)
    }
    
    @objc
    private func popPage() {
        flowDelegate?.popPage()
    }
    
    private func setup() {
        view.addSubview(contentView)
        contentView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension PurchaseMonthsViewController: PurchaseMonthsDelegate {
    
}
