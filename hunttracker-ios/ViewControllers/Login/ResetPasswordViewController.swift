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
    private let titleLabel = UILabel()
    private let emailTextField = TextField()
    private let loginButton = Button()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDelegate = self
        
        title = gettext("reset-password-title")
        view.backgroundColor = UIColor.white
        
        titleLabel.text = gettext("reset-password-text")
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0

        emailTextField.placeholder = gettext("email-placeholder")
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        if #available(iOS 11, *) {
            emailTextField.textContentType = .username
        }
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "login_background")
        backgroundImage.clipsToBounds = true
        
        loginButton.setTitle(gettext("send-email-button"), for: .normal)
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLogin)))
        
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(loginButton)
        
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
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -ViewConstants.formLeftRightSpacing),
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: ViewConstants.formControlSpacing*1.5),
            loginButton.heightAnchor.constraint(equalToConstant: ViewConstants.formControlHeight),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.formLeftRightSpacing),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.formLeftRightSpacing),
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
