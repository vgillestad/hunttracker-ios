//
//  AppCoordinator.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 03/09/2020.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window:UIWindow
    private weak var loginNavigationController:LoginNavigationController?
    private let keyChain:KeyChainWrapper = KeyChainWrapperImpl()
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        keyChain.hasToken()
            ? showWebView()
            : showLogin()
    }
    
    private func showLogin() {
        let vm = LoginViewModel(coordinatorDelegate: self)
        let vc = LoginViewController()
        vc.viewModel = vm
        let nc = LoginNavigationController(rootViewController: vc)
        loginNavigationController = nc
        window.rootViewController = nc
        window.makeKeyAndVisible()
    }
    
    private func showWebView() {
        guard let token = keyChain.getToken() else { showLogin(); return }
        let vc = WebViewController()
        vc.viewModel = WebViewViewModel(coordinatorDelegate: self, token: token)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator : LoginCoordinatorDelegate {
    func didLogin(token: String) {
        keyChain.setToken(token)
        showWebView()
    }
    
    func didTapResetPassword(email: String?) {
        let vc = ResetPasswordViewController()
        vc.viewModel = ResetPasswordViewModel(coordinatorDelegate: self)
        loginNavigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapRegister(email: String?) {
        let vc = RegisterViewController()
        vc.viewModel = RegisterViewModel(coordinatorDelegate: self)
        loginNavigationController?.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator : ResetPasswordViewModelDelegate, RegisterViewModelDelegate {
    func didComplete() {
        loginNavigationController?.popViewController(animated: true)
    }
}

extension AppCoordinator : WebViewCoordinatorDelegate {
    func didLogout() {
        keyChain.removeToken()
        showLogin()
    }
}
