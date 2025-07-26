//
//  HomeViewController.swift
//  ContaAqui
//
//  Created by Carlos Silva on 18/07/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    let flowDelegate: HomeFlowDelegate
    
    init(contentView: HomeView, flowDelegate: HomeFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        setup()
        buttonConfigTapped()
        checkExistData()
    }
    
    private func checkExistData() {
        if let user = UserDefaultsManager.loadUser() {
            contentView.title.text = "olá \(user.name) !"
        }
        
        if let savedImage = UserDefaultsManager.loadProfileImage() {
            contentView.profileImage.image = savedImage
        }
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func buttonConfigTapped() {
        self.contentView.logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        self.contentView.configIcon.addTarget(self, action: #selector(configIconAction), for: .touchUpInside)
    }
    
    @objc
    private func logoutAction() {
        UserDefaultsManager.removeUser()
        self.flowDelegate.logout()
    }
    
    @objc
    private func configIconAction() {
        self.flowDelegate.navigateToPurchase()
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapProfileImage() {
        selectProfileImage()
    }
    
    
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = editedImage
            UserDefaultsManager.saveProfileImage(image: editedImage)
// salvar imagem
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
            UserDefaultsManager.saveProfileImage(image: originalImage)
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
