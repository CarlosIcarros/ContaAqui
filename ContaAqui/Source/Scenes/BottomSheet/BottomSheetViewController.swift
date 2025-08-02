//
//  BottomSheetViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 26/07/25.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController {
    let contentView: BottomSheetView
    let flowDelegate: BottomSheetFlowDelegate
    private let viewModel = BottomSheetViewModel()
    
    init(contentView: BottomSheetView, flowDelegate: BottomSheetFlowDelegate) {
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
        contentView.closeIcon.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        
        self.contentView.closeIcon.addGestureRecognizer(tapGesture)
        
        contentView.saveButton.button.addTarget(self, action: #selector(addButtonTapper), for: .touchUpInside)
    }
    
    @objc
    private func closeButtonTapped() {
        self.flowDelegate.closeModal()
    }
    
    @objc
    private func addButtonTapper() {
        let title = contentView.titleInput.textField.text ?? ""
        let category = contentView.categoryInput.textField.text ?? ""
        let dateInput = contentView.inputDate.textField.text ?? ""
        let money = contentView.moneyInput.textField.text ?? ""
        
        viewModel.addTransaction(title: title, category: category, money: money, date: dateInput, income: false)
        self.flowDelegate.didAddTransaction()
        self.flowDelegate.closeModal()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}
