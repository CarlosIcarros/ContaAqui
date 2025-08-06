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
    let viewModel = PurchaseMonthsViewModel()
    
    private var transationLimit: [TransactionLimit] = []
    
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
        loadData()
    }
    
    func loadData() {
        transationLimit = viewModel.fetchData()
    }
    
    private func configButton() {
        self.contentView.backButton.addTarget(self, action: #selector(popPage), for: .touchUpInside)
        
        self.contentView.purchaseButton.button.addTarget(self, action: #selector(createLimitMonth), for: .touchUpInside)
    }
    
    @objc
    private func popPage() {
        flowDelegate?.popPage()
    }
    
    @objc
    private func createLimitMonth() {
        let date = self.contentView.dateInput.textField.text ?? ""
        let value = self.contentView.moneyInput.textField.text ?? ""
        
        self.createPurchaseMonth(date: date, value: value)
        
        self.contentView.dateInput.textField.text = ""
        self.contentView.moneyInput.textField.text = ""
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
    func createPurchaseMonth(date: String, value: String) {
        DBHelper.shared.insertLimitMonth(date: date, money: value)
    }
}

extension PurchaseMonthsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension PurchaseMonthsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return transationLimit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celula = tableView.dequeueReusableCell(withIdentifier: TransactionLimitCell.identifier, for: indexPath) as? TransactionLimitCell else {
            return UITableViewCell()
        }
        
        let item = transationLimit[indexPath.section]
        celula.configure(with: item)
        celula.backgroundColor = Colors.gray100
        celula.onDelete = { [weak self] in
            let itemId = self?.transationLimit[indexPath.section].id
            if let id = itemId {
                // todo precisa deletar e reload data
            }
        }
        
        return celula
    }
}
