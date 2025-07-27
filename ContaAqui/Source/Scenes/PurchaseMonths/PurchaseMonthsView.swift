//
//  PurchaseMonthsView.swift
//  ContaAqui
//
//  Created by Carlos Silva on 23/07/25.
//

import Foundation
import UIKit

class PurchaseMonthsView: UIView {
    public weak var delegate: PurchaseMonthsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(image, for: .normal)

        button.tintColor = Colors.gray500
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = Text.titleSmBold
        label.textColor = Colors.gray700
        label.text = "orçamentos mensais"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = Text.textSm
        label.textColor = Colors.gray500
        label.text = "Organize seus limites de gastos por mês"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    private let purchaseContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.cornerRadius = 8
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let purchaseTitle: UILabel = {
        let label = UILabel()
        label.text = "Novo orçamento"
        label.font = Text.title2Xs
        label.textColor = Colors.gray500
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let divider: Divider = {
        let divider = Divider()
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        return divider
    }()
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let dateInput: Input = {
        let field = Input(placeHolder: "00/0000", iconName: "calendar")
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    
    private let moneyInput: Input = {
        let field = Input(placeHolder: "R$ 0,00", textLeft: "R$")
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let purchaseButton: Button = {
        let button = Button(title: "Adicionar")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let launchContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let launchText: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray500
        label.font = Text.title2Xs
        label.text = "orçamentos cadastrados"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let launchdivider: Divider = {
        let view = Divider()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let launchImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "text.document")
        image.tintColor = Colors.gray500
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let launchDescription: UILabel = {
        let label = UILabel()
        label.text = "Você ainda não registrou nenhum orçamento"
        label.numberOfLines = 0
        label.font = Text.textXs
        label.textColor = Colors.gray500
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        self.backgroundColor = Colors.gray200
        addSubview(backgroundHeader)
        backgroundHeader.addSubview(backButton)
        backgroundHeader.addSubview(title)
        backgroundHeader.addSubview(subTitle)
        
        addSubview(purchaseContainer)
        purchaseContainer.addSubview(purchaseTitle)
        purchaseContainer.addSubview(divider)
        stackView.addArrangedSubview(dateInput)
        stackView.addArrangedSubview(moneyInput)
        purchaseContainer.addSubview(stackView)
        purchaseContainer.addSubview(purchaseButton)
        
        addSubview(launchContainer)
        launchContainer.addSubview(launchText)
        launchContainer.addSubview(launchdivider)
        launchContainer.addSubview(launchImage)
        launchContainer.addSubview(launchDescription)
    
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundHeader.topAnchor.constraint(equalTo: self.topAnchor,),
            backgroundHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundHeader.heightAnchor.constraint(equalToConstant: 140),
            
            backButton.topAnchor.constraint(equalTo: self.backgroundHeader.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            title.topAnchor.constraint(equalTo: backButton.topAnchor),
            title.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            
            purchaseContainer.topAnchor.constraint(equalTo: backgroundHeader.bottomAnchor, constant: 20),
            purchaseContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            purchaseContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            purchaseContainer.bottomAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: 24),
            
            purchaseTitle.topAnchor.constraint(equalTo: purchaseContainer.topAnchor, constant: 14),
            purchaseTitle.leadingAnchor.constraint(equalTo: purchaseContainer.leadingAnchor, constant: 20),
            
            divider.topAnchor.constraint(equalTo: purchaseTitle.bottomAnchor, constant: 14),
            divider.leadingAnchor.constraint(equalTo: purchaseContainer.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: purchaseContainer.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: purchaseContainer.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: purchaseContainer.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 48),
            
            purchaseButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            purchaseButton.leadingAnchor.constraint(equalTo: purchaseContainer.leadingAnchor, constant: 20),
            purchaseButton.trailingAnchor.constraint(equalTo: purchaseContainer.trailingAnchor, constant: -20),
            purchaseButton.heightAnchor.constraint(equalToConstant: 48),
            
            launchContainer.topAnchor.constraint(equalTo: purchaseContainer.bottomAnchor, constant: 20),
            launchContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            launchContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            launchContainer.heightAnchor.constraint(equalToConstant: 130),
            
            launchText.topAnchor.constraint(equalTo: launchContainer.topAnchor, constant: 15),
            launchText.leadingAnchor.constraint(equalTo: launchContainer.leadingAnchor, constant: 20),

            launchdivider.topAnchor.constraint(equalTo: launchText.bottomAnchor, constant: 12),
            launchdivider.leadingAnchor.constraint(equalTo: launchContainer.leadingAnchor),
            launchdivider.trailingAnchor.constraint(equalTo: launchContainer.trailingAnchor),
            
            launchImage.topAnchor.constraint(equalTo: launchdivider.bottomAnchor, constant: 20),
            launchImage.leadingAnchor.constraint(equalTo: launchContainer.leadingAnchor, constant: 24),
            launchImage.widthAnchor.constraint(equalToConstant: 32),
            launchImage.heightAnchor.constraint(equalToConstant: 32),
            
            launchDescription.leadingAnchor.constraint(equalTo: launchImage.trailingAnchor, constant: 20),
            launchDescription.topAnchor.constraint(equalTo: launchdivider.bottomAnchor, constant: 20),
            launchDescription.trailingAnchor.constraint(equalTo: launchContainer.trailingAnchor, constant: -20),
  
        ])
    }
    
}
