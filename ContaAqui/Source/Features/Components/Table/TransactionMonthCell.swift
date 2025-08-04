//
//  TransactionMonthCell.swift
//  ContaAqui
//
//  Created by Carlos Silva on 31/07/25.
//

import Foundation
import UIKit

class TransactionMonthCell: UITableViewCell {
    static let identifier = "TransactionMonthCell"
    var onDelete: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = .zero
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        setupView()
        configuraButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerIcon: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "basket")
        imageView.tintColor = Colors.magenta
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = Text.textSmBold
        label.textColor = Colors.gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = Text.textXs
        label.textColor = Colors.gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let textValue: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray700
        label.font = Text.textXs
        label.text = "R$"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray700
        label.font = Text.titleMd
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let trashIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "trash")
        imageView.tintColor = Colors.magenta
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    public var genericIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        
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
    
    func setupView() {
        addSubview(containerIcon)
        containerIcon.addSubview(icon)
        
        monthStack.addArrangedSubview(containerIcon)
        
        textStack.addArrangedSubview(title)
        textStack.addArrangedSubview(descriptionTitle)
        
        mainStack.addArrangedSubview(monthStack)
        mainStack.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(textValue)
        mainStack.addArrangedSubview(value)
        mainStack.addArrangedSubview(genericIcon)
        mainStack.addArrangedSubview(trashIcon)
        
        contentView.addSubview(mainStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerIcon.heightAnchor.constraint(equalToConstant: 32),
            containerIcon.widthAnchor.constraint(equalToConstant: 32),
            
            icon.widthAnchor.constraint(equalToConstant: 16),
            icon.heightAnchor.constraint(equalToConstant: 16),
            icon.centerXAnchor.constraint(equalTo: containerIcon.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: containerIcon.centerYAnchor),
            
            genericIcon.heightAnchor.constraint(equalToConstant: 14),
            genericIcon.widthAnchor.constraint(equalToConstant: 14),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    private func configuraButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trashIconTapped))
        
        trashIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc private func trashIconTapped() {
        onDelete?()
    }
    
    
    func configure(with transaction: TransactionMonth) {
        title.text = transaction.title
        descriptionTitle.text = transaction.date
        
        value.text = transaction.money
        let isIncome = transaction.income == "false"
        genericIcon.image = isIncome ? UIImage(systemName: "arrowtriangle.down.fill") : UIImage(systemName: "arrowtriangle.up.fill")
        genericIcon.tintColor = isIncome ? Colors.red : Colors.green
    }
    
}
