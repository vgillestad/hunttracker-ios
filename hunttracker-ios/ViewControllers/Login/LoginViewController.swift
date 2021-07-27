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
        navigationItem.backButtonTitle = ""

        emailTextField.placeholder = gettext("email-placeholder")
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        if #available(iOS 11, *) {
            emailTextField.textContentType = .username
        }
        
        passwordTextField.placeholder = gettext("password-placeholder")
        passwordTextField.isSecureTextEntry = true
        if #available(iOS 11, *) {
            passwordTextField.textContentType = .password
        }
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "login_background")
        backgroundImage.clipsToBounds = true
        
        loginButton.setTitle(gettext("login-button"), for: .normal)
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLogin)))
        
        resetPasswordButton.setTitle(gettext("forgot-password-button"), for: .normal)
        resetPasswordButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapResetPassword)))
        
        registerButton.setTitle(gettext("register-button"), for: .normal)
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
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewConstants.topToFirstContent),
            emailTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            emailTextField.leftAnchor.constraint(equalTo: loginButton.leftAnchor),
            emailTextField.rightAnchor.constraint(equalTo: loginButton.rightAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ViewConstants.formControlSpacing),
            passwordTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: loginButton.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: loginButton.rightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: ViewConstants.formControlSpacing*1.5),
            loginButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formControlSpacing*2),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formControlSpacing*2),
            
            resetPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: ViewConstants.formControlSpacing),
            resetPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            resetPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing),
            
            registerButton.topAnchor.constraint(equalTo: resetPasswordButton.bottomAnchor, constant: ViewConstants.formControlSpacing),
            registerButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing),
        ])
    }
    
    @objc func didTapLogin(sender: UITapGestureRecognizer) {
        viewModel.didTapLogin(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func didTapResetPassword(sender: UITapGestureRecognizer) {
        viewModel.didTapResetPassword(email: emailTextField.text)
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
