//
//  TransactionLimitCell.swift
//  ContaAqui
//
//  Created by Carlos Silva on 04/08/25.
//

import Foundation
import UIKit

class TransactionLimitCell: UITableViewCell {
    static let identifier = "TransactionMonthCell"
    var onDelete: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separatorInset =  .zero
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        setupView()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = Colors.gray700
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let month: UILabel = {
        let label = UILabel()
        label.font = Text.titleSmBold
        label.textColor = Colors.gray700
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let year: UILabel = {
        let label = UILabel()
        label.tintColor = Colors.gray600
        label.font = Text.textXs
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moneyInfo: UILabel = {
        let label = UILabel()
        label.font = Text.textXs
        label.tintColor = Colors.gray700
        
        label.text = "R$"
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    private let valueInfo: UILabel = {
        let label = UILabel()
        label.font = Text.titleMd
        label.tintColor = Colors.gray700
        
        label.translatesAutoresizingMaskIntoConstraints  = false
        return label
    }()
    
    private let trashIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "trash")
        imageView.tintColor = Colors.magenta
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let monthStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupView() {
        monthStack.addArrangedSubview(iconImageView)
        monthStack.addArrangedSubview(month)
        monthStack.addArrangedSubview(year)
        
        mainStack.addArrangedSubview(monthStack)
        mainStack.addArrangedSubview(moneyInfo)
        mainStack.addArrangedSubview(valueInfo)
        mainStack.addArrangedSubview(trashIcon)
        
        contentView.addSubview(mainStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func configureButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trashIconTapper))
        
        trashIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func trashIconTapper() {
        onDelete?()
    }
    
    public func configure(with limitMonth: TransactionLimit) {
        month.text = limitMonth.date
        year.text = "2025"
        valueInfo.text = limitMonth.money
    }
}
