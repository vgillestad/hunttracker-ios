//
//  ResetPasswordViewModel.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 13/09/2020.
//

import Foundation

protocol ResetPasswordViewModelDelegate : AnyObject {
    func didComplete()
}

protocol ResetPasswordViewModelViewDelegate : AnyObject {
    func showIsFetching(_ isFeching:Bool)
    func showAlert(title:String, message:String)
    func showAlert(title:String, message:String, onConfirm:(() -> Void)?)
    func showUnexpectedErrorAlert()
}

class ResetPasswordViewModel {
    var isFetching:Bool = false {
        didSet { viewDelegate?.showIsFetching(isFetching) }
    }
    
    private weak var coordinatorDelegate:ResetPasswordViewModelDelegate?
    weak var viewDelegate:ResetPasswordViewModelViewDelegate?
    
    init(coordinatorDelegate:ResetPasswordViewModelDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func didTapResetPassword(email:String?) {
        isFetching = true
        var request = URLRequest(url: URL(string: ApiConstants.resetPasswordUrl.absoluteString)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["email":email], options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.isFetching = false
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        self?.viewDelegate?.showAlert(title: gettext("reset-password-email-sent-title"), message: gettext("reset-password-email-sent-message")) {
                            self?.coordinatorDelegate?.didComplete()
                        }
                    }
                    else if httpResponse.statusCode == 404 {
                        self?.viewDelegate?.showAlert(title: "reset-password-email-not-found-title", message: "reset-password-email-not-found-message")
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
