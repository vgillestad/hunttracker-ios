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
    private let titleLabel = UILabel()
    private let emailTextField = TextField()
    private let passwordTextField = TextField()
    private let registerButton = Button()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDelegate = self
        title = "Register new user"
        view.backgroundColor = UIColor.white

        titleLabel.text = "Enter your e-mail address and your wanted password to register a new user."
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        
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
        backgroundImage.clipsToBounds = true
        backgroundImage.image = UIImage(named: "login_background")
        
        registerButton.setTitle("Register", for: .normal)
        
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        setContraints()
    }
    
    private func setContraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewConstants.topToFirstContent),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing),
        ])
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewConstants.formControlSpacing),
            emailTextField.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ViewConstants.formControlSpacing),
            passwordTextField.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing)
        ])
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: ViewConstants.formControlSpacing*1.5),
            registerButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing),
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
        registerButton.isFecthing = isFeching
    }
}
