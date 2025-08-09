//
//  SelectionMonths.swift
//  ContaAqui
//
//  Created by Carlos Silva on 19/07/25.
//

import Foundation
import UIKit

protocol SelectionMonthsDelegate: AnyObject {
    func monthDidChange(to month: String)
}

class SelectionMonths: UIView {
    weak var delegate: SelectionMonthsDelegate?
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
        
        // Configurar ações das setas
        leftArrowButton.addTarget(self, action: #selector(leftArrowTapped), for: .touchUpInside)
        rightArrowButton.addTarget(self, action: #selector(rightArrowTapped), for: .touchUpInside)
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

        // Adicionar gesto de tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(monthTapped(_:)))
        container.addGestureRecognizer(tapGesture)
        container.tag = months.firstIndex(of: month) ?? 0

        return container
    }
    
    // MARK: - Actions
    @objc private func leftArrowTapped() {
        guard let currentIndex = months.firstIndex(of: selectedMonth) else { return }
        let newIndex = max(0, currentIndex - 1)
        let newMonth = months[newIndex]
        updateSelectedMonth(to: newMonth)
        delegate?.monthDidChange(to: newMonth)
    }
    
    @objc private func rightArrowTapped() {
        guard let currentIndex = months.firstIndex(of: selectedMonth) else { return }
        let newIndex = min(months.count - 1, currentIndex + 1)
        let newMonth = months[newIndex]
        updateSelectedMonth(to: newMonth)
        delegate?.monthDidChange(to: newMonth)
    }
    
    @objc private func monthTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view else { return }
        let monthIndex = tappedView.tag
        let newMonth = months[monthIndex]
        updateSelectedMonth(to: newMonth)
        delegate?.monthDidChange(to: newMonth)
    }

    // MARK: - Public API

    func updateSelectedMonth(to newMonth: String) {
        selectedMonth = newMonth
        setupMonths()
    }
}
