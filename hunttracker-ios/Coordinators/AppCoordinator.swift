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
        let vc = LoginViewController()
        vc.viewModel = LoginViewModel(coordinatorDelegate: self)
        window.rootViewController = vc
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
}

extension AppCoordinator : WebViewCoordinatorDelegate {
    func didLogout() {
        keyChain.removeToken()
        showLogin()
    }
}
