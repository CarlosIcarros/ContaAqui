//
//  BottomSheetViewModel.swift
//  ContaAqui
//
//  Created by Carlos Silva on 28/07/25.
//

import Foundation

class BottomSheetViewModel {
    func addTransaction(title: String, category: String, money: String, date: String, income: Bool) {
        DBHelper.shared.insertTransaction(title: title, category: category, money: money, date: date, income: income)
    }
}
