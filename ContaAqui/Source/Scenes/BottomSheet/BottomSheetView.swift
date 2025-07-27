//
//  BottomSheetView.swift
//  ContaAqui
//
//  Created by Carlos Silva on 26/07/25.
//

import Foundation
import UIKit

class BottomSheetView: UIView {
    private let title: UILabel = {
        let label = UILabel()
        label.font = Text.titleXsBold
        label.tintColor = Colors.gray700
        label.text = "NOVO LANÇAMENTO"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.tintColor = Colors.gray500
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleInput: Input = {
       let input = Input(placeHolder: "Título da transação")
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    private let categoryInput: Input = {
       let input = Input(placeHolder: "Categoria", iconName: "tag")
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    private let inputDate: Input = {
       let input = Input(placeHolder: "00/00/00", iconName: "calendar")
        
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    private let moneyInput: Input = {
       let input = Input(placeHolder: "0,00", textLeft: "R$")
        input.translatesAutoresizingMaskIntoConstraints = false
        
        return input
    }()
    
    private let stackViewInput: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let incomeButton: ButtonStatus = {
        let button = ButtonStatus(status: .positive, title: "Entrada")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let outcomeButton: ButtonStatus = {
        let button = ButtonStatus(status: .negative, title: "Saída")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let stackViewButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let divider: Divider = {
       let divider = Divider()
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let saveButton: Button = {
        let button = Button(title: "Salvar")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        addSubview(title)
        addSubview(closeIcon)
        addSubview(titleInput)
        addSubview(categoryInput)
        stackViewInput.addArrangedSubview(inputDate)
        stackViewInput.addArrangedSubview(moneyInput)
        addSubview(stackViewInput)
        stackViewButton.addArrangedSubview(incomeButton)
        stackViewButton.addArrangedSubview(outcomeButton)
        addSubview(stackViewButton)
        addSubview(divider)
        addSubview(saveButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            closeIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            closeIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            titleInput.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 36),
            titleInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            titleInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            titleInput.heightAnchor.constraint(equalToConstant: 48),
            
            categoryInput.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 12),
            categoryInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            categoryInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            categoryInput.heightAnchor.constraint(equalToConstant: 48),
            
            stackViewInput.topAnchor.constraint(equalTo: categoryInput.bottomAnchor, constant: 12),
            stackViewInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackViewInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackViewInput.heightAnchor.constraint(equalToConstant: 48),
            
            stackViewButton.topAnchor.constraint(equalTo: stackViewInput.bottomAnchor, constant: 12),
            stackViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            stackViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            stackViewButton.heightAnchor.constraint(equalToConstant: 48),
            
            divider.topAnchor.constraint(equalTo: stackViewButton.bottomAnchor, constant: 24),
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            saveButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 24),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            
        ])
    }
    
}
