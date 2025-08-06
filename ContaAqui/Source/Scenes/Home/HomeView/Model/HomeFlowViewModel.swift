//
//  HomeFlowViewModel.swift
//  ContaAqui
//
//  Created by Carlos Silva on 30/07/25.
//

import Foundation

class HomeFlowViewModel {
    func fetchData() -> [TransactionMonth] {
        return DBHelper.shared.fetchTrancastionMonth()
    }
    
    func fetchDataLimit() -> [TransactionLimit] {
        return DBHelper.shared.fetchTrancastionLimit()
    }
}
