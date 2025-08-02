//
//  TransactionMonthTable.swift
//  ContaAqui
//
//  Created by Carlos Silva on 31/07/25.
//

import Foundation
import UIKit

class TransactionMonthTable: UITableView {
    
    init() {
        
        super.init(frame: .zero, style: .plain)
        
        setupView()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    };
    
    private func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rowHeight = 44
        self.tableFooterView = UIView()
        
    }
    
    private func setupTableView() {
        self.reloadData()
    }
    
}

