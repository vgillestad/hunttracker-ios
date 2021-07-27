//
//  RegisterViewModel.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 14/09/2020.
//

import Foundation

protocol RegisterViewModelDelegate : AnyObject {
    func didComplete()
}

protocol RegisterViewModelViewDelegate : AnyObject {
    func showIsFetching(_ isFeching:Bool)
    func showAlert(title:String, message:String)
    func showAlert(title:String, message:String, onConfirm:(() -> Void)?)
    func showUnexpectedErrorAlert()
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
    
    func didTapRegister(firstName:String?, lastName:String?, email:String?, password:String?) {
        isFetching = true
        
        var request = URLRequest(url: URL(string: ApiConstants.registerUrl.absoluteString)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ], options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.isFetching = false
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        self?.viewDelegate?.showAlert(title: gettext("register-complete-title"), message: gettext("register-complete-message")) {
                            self?.coordinatorDelegate?.didComplete()
                        }
                    }
                    if httpResponse.statusCode == 409 {
                        self?.viewDelegate?.showAlert(title: gettext("register-already-exists-title"), message: gettext("register-already-exists-message"))
                    }
                    else {
                        self?.viewDelegate?.showUnexpectedErrorAlert()
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    self?.viewDelegate?.showUnexpectedErrorAlert()
                }
            }
        }
        task.resume()
    }
}
