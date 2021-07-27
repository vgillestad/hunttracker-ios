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
    private let firstNameTextField = TextField()
    private let lastNameTextField = TextField()
    private let emailTextField = TextField()
    private let passwordTextField = TextField()
    private let registerButton = Button()
    
    private let form = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDelegate = self
        title = gettext("register-title")
        view.backgroundColor = UIColor.white

        titleLabel.text = gettext("register-text")
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        
        form.axis = .vertical
        form.spacing = ViewConstants.formControlSpacing
        
        firstNameTextField.placeholder = gettext("first-name-placeholder")
        lastNameTextField.placeholder = gettext("last-name-placeholder")
        
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
        backgroundImage.clipsToBounds = true
        backgroundImage.image = UIImage(named: "login_background")
        
        registerButton.setTitle(gettext("register-button"), for: .normal)
        registerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRegister)))
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(form)
        
        form.addArrangedSubview(firstNameTextField)
        form.addArrangedSubview(lastNameTextField)
        form.addArrangedSubview(emailTextField)
        form.addArrangedSubview(passwordTextField)
        form.addArrangedSubview(registerButton)
        
        setContraints()
    }
    
    private func setContraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewConstants.topToFirstContent),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing),
        ])
        
        form.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewConstants.formControlSpacing),
            form.leftAnchor.constraint(equalTo: view.leftAnchor, constant: ViewConstants.formLeftRightSpacing),
            form.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing)
        ])
        
        let formViews:[UIView] = [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, registerButton]
        formViews.forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        NSLayoutConstraint.activate(formViews.map{$0.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight)})
        
        form.setCustomSpacing(ViewConstants.formControlSpacing*1.5, after: passwordTextField)
    }
    
    @objc func didTapRegister() {
        viewModel.didTapRegister(
            firstName: firstNameTextField.text,
            lastName: lastNameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text
        )
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
