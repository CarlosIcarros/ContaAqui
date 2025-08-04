//
//  HomeViewDelegate.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func didTapProfileImage()
    func deleteMonth(byId id: Int)
}
