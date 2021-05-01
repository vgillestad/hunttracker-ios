//
//  ResetPasswordViewController.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 13/09/2020.
//

import Foundation
import UIKit

class ResetPasswordViewController: AlertViewController {
    
    var viewModel:ResetPasswordViewModel!
    
    private let backgroundImage = UIImageView()
    private let emailTextField = TextField()
    private let loginButton = Button()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDelegate = self
        
        view.backgroundColor = UIColor.white

        emailTextField.placeholder = "E-Mail"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        if #available(iOS 11, *) {
            emailTextField.textContentType = .username
        }
        
        backgroundImage.image = UIImage(named: "login_background")
        backgroundImage.contentMode = .scaleAspectFill
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLogin)))
        
        view.addSubview(backgroundImage)
        view.addSubview(emailTextField)
        view.addSubview(loginButton)
        
        setContraints()
    }
    
    private func setContraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            loginButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formControlSpacing*2),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formControlSpacing*2),
            loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ViewConstants.formControlSpacing*1.5),
        ])
    }
    
    @objc func didTapLogin() {
        viewModel.didTapResetPassword(email: emailTextField.text)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImage.frame = view.bounds
    }
}

extension ResetPasswordViewController : ResetPasswordViewModelViewDelegate {
    
    func showIsFetching(_ isFeching: Bool) {
        loginButton.isFecthing = isFeching
    }
}
