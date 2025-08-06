//
//  PurchaseMonthsViewModel.swift
//  ContaAqui
//
//  Created by Carlos Silva on 05/08/25.
//

import Foundation

class PurchaseMonthsViewModel {
    func fetchData() -> [TransactionLimit] {
        return DBHelper.shared.fetchTrancastionLimit()
    }
}
