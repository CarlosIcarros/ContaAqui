//
//  HomeView.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation
import UIKit

 
class HomeView: UIView {
    public weak var delegate: HomeViewDelegate?
    
    private let backgroundHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.backgroundColor = UIColor.systemGray5
    
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = Text.titleSmBold
        label.textColor = Colors.gray700
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = Text.textSm
        label.text = "Vamos organizar suas finanças?"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.forward", withConfiguration: config)
        button.setImage(image, for: .normal)
        
        button.tintColor = Colors.gray500
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    private let selectionMonths: SelectionMonths = {
        let view = SelectionMonths()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let containerBudget: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Colors.gray700
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        
        let colorTop =  Colors.gray700.cgColor
        let colorBottom = Colors.gray600.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        containerView.layer.insertSublayer(gradientLayer, at: 0)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let monthBudget: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let boldText = "AGOSTO"
        let normalText = " /2025"
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: Colors.gray100
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: Colors.gray500
        ]
        
        let attributedString = NSMutableAttributedString(string: boldText, attributes: boldAttributes)
        attributedString.append(NSAttributedString(string: normalText, attributes: normalAttributes))
        
        label.attributedText = attributedString
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let configIcon: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "gearshape.fill")
        button.setImage(image, for: .normal)
        
        button.tintColor = Colors.gray100
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textAvailiableBudget: UILabel = {
        let label = UILabel()
        label.text = "Orçamento disponível"
        label.textColor = Colors.gray400
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let divider: Divider = {
        let view = Divider()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let limitButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Definir orçamento", for: .normal)
        button.setTitleColor(Colors.magenta, for: .normal)
        button.backgroundColor  = Colors.magenta.withAlphaComponent(0.1)
        button.layer.borderColor = Colors.magenta.cgColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let usignLimit: LimitComponent = {
        let limitComponent = LimitComponent(text: "Usado", subText: "R$ 0,00",  alignment: .left)

        limitComponent.translatesAutoresizingMaskIntoConstraints = false
        return limitComponent
    }()
    
    private let availableLimit: LimitComponent = {
        let limitComponent = LimitComponent(text: "Limite", subText: "∞", alignment: .right)
        
        limitComponent.translatesAutoresizingMaskIntoConstraints = false
        
        return limitComponent
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
        label.text = "LANÇAMENTOS"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let launchValue: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = Colors.gray600
        label.backgroundColor = Colors.gray300
        label.layer.cornerRadius = 10
        
        label.clipsToBounds = true
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
        label.text = "Você ainda não registrou despesas ou receitas neste mês"
        label.numberOfLines = 0
        label.font = Text.textXs
        label.textColor = Colors.gray500
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fabButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = Colors.gray700
        button.layer.cornerRadius = 24
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4

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
        self.backgroundColor = Colors.gray200
        addSubview(backgroundHeader)
        backgroundHeader.addSubview(profileImage)
        backgroundHeader.addSubview(title)
        backgroundHeader.addSubview(subTitle)
        backgroundHeader.addSubview(logoutButton)
        addSubview(selectionMonths)
        
        addSubview(containerBudget)
        containerBudget.addSubview(monthBudget)
        containerBudget.addSubview(configIcon)
        containerBudget.addSubview(textAvailiableBudget)
        containerBudget.addSubview(divider)
        containerBudget.addSubview(limitButton)
        containerBudget.addSubview(usignLimit)
        containerBudget.addSubview(availableLimit)
        
        addSubview(launchContainer)
        launchContainer.addSubview(launchText)
        launchContainer.addSubview(launchValue)
        launchContainer.addSubview(launchdivider)
        launchContainer.addSubview(launchImage)
        launchContainer.addSubview(launchDescription)
        
        addSubview(fabButton)
        setupConstraints()
        setupImageGesture()
    }
    
    private func setupImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTap))
        profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func profileImageTap() {
        delegate?.didTapProfileImage()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundHeader.topAnchor.constraint(equalTo: self.topAnchor,),
            backgroundHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundHeader.heightAnchor.constraint(equalToConstant: 140),
            
            profileImage.topAnchor.constraint(equalTo: self.backgroundHeader.safeAreaLayoutGuide.topAnchor, constant: 8),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40),
            
            title.topAnchor.constraint(equalTo: profileImage.topAnchor),
            title.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subTitle.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            
            logoutButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: backgroundHeader.trailingAnchor, constant: -24),
            logoutButton.heightAnchor.constraint(equalToConstant: 24),
            logoutButton.widthAnchor.constraint(equalToConstant: 24),
            
            selectionMonths.topAnchor.constraint(equalTo: backgroundHeader.bottomAnchor, constant: 24),
            selectionMonths.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            selectionMonths.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            containerBudget.topAnchor.constraint(equalTo: selectionMonths.bottomAnchor, constant: 24),
            containerBudget.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            containerBudget.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            containerBudget.heightAnchor.constraint(equalToConstant: 220),
            
            monthBudget.topAnchor.constraint(equalTo: containerBudget.topAnchor, constant: 24),
            monthBudget.leadingAnchor.constraint(equalTo: containerBudget.leadingAnchor, constant: 24),
            
            configIcon.topAnchor.constraint(equalTo: containerBudget.topAnchor, constant: 24),
            configIcon.trailingAnchor.constraint(equalTo: containerBudget.trailingAnchor, constant: -24),
            
            divider.topAnchor.constraint(equalTo: monthBudget.bottomAnchor,constant: 12),
            divider.leadingAnchor.constraint(equalTo: containerBudget.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: containerBudget.trailingAnchor, constant: -24),
            
            textAvailiableBudget.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 12),
            textAvailiableBudget.leadingAnchor.constraint(equalTo: containerBudget.leadingAnchor, constant: 24),
            
            limitButton.topAnchor.constraint(equalTo: textAvailiableBudget.bottomAnchor, constant: 12),
            limitButton.trailingAnchor.constraint(equalTo: containerBudget.trailingAnchor, constant: -24),
            limitButton.leadingAnchor.constraint(equalTo: containerBudget.leadingAnchor, constant: 24),
            limitButton.heightAnchor.constraint(equalToConstant: 40),
            
            usignLimit.topAnchor.constraint(equalTo: limitButton.bottomAnchor, constant: 24),
            usignLimit.leadingAnchor.constraint(equalTo: containerBudget.leadingAnchor, constant: 24),
            usignLimit.widthAnchor.constraint(equalToConstant: 60),
            
            availableLimit.topAnchor.constraint(equalTo: limitButton.bottomAnchor, constant: 24),
            availableLimit.trailingAnchor.constraint(equalTo: containerBudget.trailingAnchor, constant: -24),
            
            launchContainer.topAnchor.constraint(equalTo: containerBudget.bottomAnchor, constant: 20),
            launchContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            launchContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            launchContainer.heightAnchor.constraint(equalToConstant: 130),
            
            launchText.topAnchor.constraint(equalTo: launchContainer.topAnchor, constant: 15),
            launchText.leadingAnchor.constraint(equalTo: launchContainer.leadingAnchor, constant: 20),
            
            launchValue.topAnchor.constraint(equalTo: launchContainer.topAnchor, constant: 15),
            launchValue.trailingAnchor.constraint(equalTo: launchContainer.trailingAnchor, constant: -16),
            launchValue.heightAnchor.constraint(equalToConstant: 18),
            launchValue.widthAnchor.constraint(equalToConstant: 24),
            
            launchdivider.topAnchor.constraint(equalTo: launchValue.bottomAnchor, constant: 12),
            launchdivider.leadingAnchor.constraint(equalTo: launchContainer.leadingAnchor),
            launchdivider.trailingAnchor.constraint(equalTo: launchContainer.trailingAnchor),
            
            launchImage.topAnchor.constraint(equalTo: launchdivider.bottomAnchor, constant: 20),
            launchImage.leadingAnchor.constraint(equalTo: launchContainer.leadingAnchor, constant: 24),
            launchImage.widthAnchor.constraint(equalToConstant: 32),
            launchImage.heightAnchor.constraint(equalToConstant: 32),
            
            launchDescription.leadingAnchor.constraint(equalTo: launchImage.trailingAnchor, constant: 20),
            launchDescription.topAnchor.constraint(equalTo: launchdivider.bottomAnchor, constant: 20),
            launchDescription.trailingAnchor.constraint(equalTo: launchContainer.trailingAnchor, constant: -20),
            
            fabButton.widthAnchor.constraint(equalToConstant: 48),
            fabButton.heightAnchor.constraint(equalToConstant: 48),
            fabButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            fabButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
}

