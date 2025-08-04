//
//  BottomSheetViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 26/07/25.
//

import Foundation
import UIKit

class BottomSheetViewController: UIViewController {
    let contentView: BottomSheetView
    let flowDelegate: BottomSheetFlowDelegate
    private let viewModel = BottomSheetViewModel()
    private var valueSelect: String?
    
    init(contentView: BottomSheetView, flowDelegate: BottomSheetFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configButton()
    }
    
    func agendarNotificacao() {
        let conteudo = UNMutableNotificationContent()
        conteudo.title = "Lembrete"
        conteudo.body = "Você tem uma transação para revisar."
        conteudo.sound = UNNotificationSound.default
        
        let agora = Date()
        var component = Calendar.current.dateComponents([.year, .month, .day], from: agora)
        
        component.hour = 22
        component.minute = 00
        
        // Cria a data completa para hoje às 22h
        if let dataNotificacao = Calendar.current.date(from: component), dataNotificacao < agora {
            // Já passou de 22h hoje? Agenda para amanhã
            if let amanha = Calendar.current.date(byAdding: .day, value: 1, to: dataNotificacao) {
                component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: amanha)
            }
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
            
            let request = UNNotificationRequest(identifier: "lembreteNotification", content: conteudo, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Erro ao agendar: \(error.localizedDescription)")
                } else {
                    print("Notificação agendada ✅")
                }
            }
        }
    }
    
    
    private func configButton() {
        contentView.closeIcon.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        
        self.contentView.closeIcon.addGestureRecognizer(tapGesture)
        
        contentView.saveButton.button.addTarget(self, action: #selector(addButtonTapper), for: .touchUpInside)
        
        contentView.incomeButton.button.addTarget(self, action: #selector(selectButtonIncome), for: .touchUpInside)
        contentView.outcomeButton.button.addTarget(self, action: #selector(selectButtonOutcome), for: .touchUpInside)
    }
    
    @objc
    private func closeButtonTapped() {
        self.flowDelegate.closeModal()
    }
    
    @objc
    private func addButtonTapper() {
        let title = contentView.titleInput.textField.text ?? ""
        let category = contentView.categoryInput.textField.text ?? ""
        let dateInput = contentView.inputDate.textField.text ?? ""
        let money = contentView.moneyInput.textField.text ?? ""
        
        viewModel.addTransaction(title: title, category: category, money: money, date: dateInput, income: valueSelect == "income")
        agendarNotificacao()
        self.flowDelegate.didAddTransaction()
        self.flowDelegate.closeModal()
    }
    
    @objc
    private func selectButtonIncome() {
        valueSelect = "income"
    }
    
    @objc
    private func selectButtonOutcome() {
        valueSelect = "outcome"
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}
