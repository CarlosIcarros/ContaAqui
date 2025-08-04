//
//  PurchaseMonthsDelegate.swift
//  ContaAqui
//
//  Created by Carlos Silva on 23/07/25.
//

import Foundation

protocol PurchaseMonthsDelegate: AnyObject {
    func createPurchaseMonth(date: String, value: String)
}
