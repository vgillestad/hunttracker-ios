//
//  RegisterViewModel.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 14/09/2020.
//

import Foundation

protocol RegisterViewModelDelegate : class {
    func didComplete()
}

protocol RegisterViewModelViewDelegate : class {
    func showIsFetching(_ isFeching:Bool)
    func showAlert(title:String, message:String)
    func showAlert(title:String, message:String, onConfirm:(() -> Void)?)
}

class RegisterViewModel {
    var isFetching:Bool = false {
        didSet { viewDelegate?.showIsFetching(isFetching) }
    }
    
    private weak var coordinatorDelegate:RegisterViewModelDelegate?
    weak var viewDelegate:RegisterViewModelViewDelegate?
    
    init(coordinatorDelegate:RegisterViewModelDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
    }
}
