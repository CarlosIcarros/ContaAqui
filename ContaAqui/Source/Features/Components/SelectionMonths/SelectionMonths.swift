//
//  SelectionMonths.swift
//  ContaAqui
//
//  Created by Carlos Silva on 19/07/25.
//

import Foundation
import UIKit

class SelectionMonths: UIView {
    private let months = [ "JUN", "JUL", "AGO", "SET", "OUT"]
    private var selectedMonth: String

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .bottom
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()

    init(selectedMonth: String = "AGO") {
        self.selectedMonth = selectedMonth
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        self.selectedMonth = "AGO"
        super.init(coder: coder)
        setupView()
    }
    
    let leftArrowButton: UIButton = {
        let button = UIButton(type: .system)

        let image = UIImage(systemName: "chevron.compact.left")
        button.setImage(image, for: .normal)
        button.tintColor = Colors.gray500
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    let rightArrowButton: UIButton = {
        let button = UIButton(type: .system)

        let image = UIImage(systemName: "chevron.compact.right")
        button.setImage(image, for: .normal)
        button.tintColor = Colors.gray500
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    
    private func setupView() {
        addSubview(stackView)
        addSubview(leftArrowButton)
        addSubview(rightArrowButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leftArrowButton.trailingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: rightArrowButton.leadingAnchor, constant: -24),
            
            leftArrowButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftArrowButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 3),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 15),
            
            rightArrowButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rightArrowButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 3),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 15)
        ])

        setupMonths()
    }

    private func setupMonths() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for month in months {
            let isSelected = (month == selectedMonth)
            let monthView = createMonthView(month: month, isSelected: isSelected)
            stackView.addArrangedSubview(monthView)
        }
    }

    private func createMonthView(month: String, isSelected: Bool) -> UIView {
        let container = UIView()

        let label = UILabel()
        label.text = month
        label.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center

        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            
        ])

        if isSelected {
            let underline = UIView()
            underline.backgroundColor = .systemPink
            underline.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(underline)

            NSLayoutConstraint.activate([
                underline.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
                underline.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                underline.widthAnchor.constraint(equalTo: label.widthAnchor),
                underline.heightAnchor.constraint(equalToConstant: 2),
                underline.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        } else {
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        }

        return container
    }

    // MARK: - Public API

    func updateSelectedMonth(to newMonth: String) {
        selectedMonth = newMonth
        setupMonths()
    }
}
