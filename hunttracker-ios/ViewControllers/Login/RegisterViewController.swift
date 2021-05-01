//
//  RegisterViewController.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 14/09/2020.
//

import Foundation
import UIKit

class RegisterViewController: AlertViewController {
    
    var viewModel:RegisterViewModel!
    
    private let backgroundImage = UIImageView()
    private let emailTextField = TextField()
    private let passwordTextField = TextField()
    private let loginButton = Button()
    private let registerButton = UIButton()

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
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        if #available(iOS 11, *) {
            passwordTextField.textContentType = .password
        }
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "login_background")
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLogin)))
        
        registerButton.setTitle("Register", for: .normal)
        
        
        view.addSubview(backgroundImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        setContraints()
    }
    
    private func setContraints() {
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ViewConstants.formControlSpacing)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formControlSpacing*2),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formControlSpacing*2),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: ViewConstants.formControlSpacing*1.5),
        ])
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formControlSpacing*2),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formControlSpacing*2),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: ViewConstants.formControlSpacing),
        ])
    }
    
    @objc func didTapLogin() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundImage.frame = view.bounds
    }
}

extension RegisterViewController : RegisterViewModelViewDelegate {
    func showIsFetching(_ isFeching: Bool) {
        loginButton.isFecthing = isFeching
    }
}
