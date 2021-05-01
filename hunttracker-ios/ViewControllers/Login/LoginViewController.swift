//
//  ViewController.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 29/08/2020.
//

import Foundation
import UIKit

class LoginViewController: AlertViewController {
    
    var viewModel:LoginViewModel!
    
    private let backgroundImage = UIImageView()
    private let emailTextField = TextField()
    private let passwordTextField = TextField()
    private let loginButton = Button()
    private let resetPasswordButton = UIButton()
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
        
        resetPasswordButton.setTitle("Forgot password?", for: .normal)
        resetPasswordButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResetPassword)))
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRegister)))
        
        view.addSubview(backgroundImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(resetPasswordButton)
        view.addSubview(registerButton)
        
        setContraints()
    }
    
    private func setContraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            passwordTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ViewConstants.formControlSpacing),
            
            loginButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formControlSpacing*2),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formControlSpacing*2),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: ViewConstants.formControlSpacing*1.5),
            
            resetPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formControlSpacing*2),
            resetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formControlSpacing*2),
            resetPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 5),
            
            registerButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formControlSpacing*2),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formControlSpacing*2),
            registerButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: ViewConstants.formControlSpacing*2),
        ])
    }
    
    @objc func didTapLogin(sender: UITapGestureRecognizer) {
        viewModel.didTapLogin(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func didTapResetPassword(sender: UITapGestureRecognizer) {
        viewModel.didTapRegister(email: emailTextField.text)
    }
    
    @objc func didTapRegister(sender: UITapGestureRecognizer) {
        viewModel.didTapRegister(email: emailTextField.text)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundImage.frame = view.bounds
    }
}

extension LoginViewController : LoginViewDelegate {
    func showIsFetching(_ isFeching: Bool) {
        loginButton.isFecthing = isFeching
    }
}
