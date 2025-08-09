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
    
    // MARK: - Month Filtered Methods
    func fetchDataByMonth(_ monthYear: String) -> [TransactionMonth] {
        return DBHelper.shared.fetchTransactionsByMonth(monthYear)
    }
    
    func fetchLimitByMonth(_ monthYear: String) -> [TransactionLimit] {
        return DBHelper.shared.fetchLimitByMonth(monthYear)
    }
    
    // MARK: - Month Helper Methods
    func getMonthYearString(from monthCode: String) -> String {
        let monthMapping = [
            "JUN": "06/2025",
            "JUL": "07/2025", 
            "AGO": "08/2025",
            "SET": "09/2025",
            "OUT": "10/2025"
        ]
        let result = monthMapping[monthCode] ?? "08/2025"

        return result
    }
}
