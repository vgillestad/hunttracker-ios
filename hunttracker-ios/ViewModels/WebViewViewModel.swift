//
//  WebViewViewModel.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 03/09/2020.
//

import Foundation

protocol WebViewCoordinatorDelegate : AnyObject {
    func didLogout()
}

struct WebViewViewModel {
    
    let token:String
    private weak var coordinatorDelegate:WebViewCoordinatorDelegate?

    init(coordinatorDelegate:WebViewCoordinatorDelegate, token:String) {
        self.coordinatorDelegate = coordinatorDelegate
        self.token = token
    }

    func didRedirectToLogin() {
        coordinatorDelegate?.didLogout()
    }
}
