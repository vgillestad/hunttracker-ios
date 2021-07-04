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
                        self?.viewDelegate?.showAlert(title: "E-Mail sent", message: "We have sent you an email with instructions on how to reset your password. You should receive it within a few seconds. Remember to check your spam folder if you don't get any e-mail") {
                            self?.coordinatorDelegate?.didComplete()
                        }
                    }
                    else {
                        self?.viewDelegate?.showAlert(title: "Unexpected error", message: "We are sorry, but an unexpected error occured.")
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    self?.viewDelegate?.showAlert(title: "Incorrect", message: "Looks like you entered an incorrect email/password")
                }
            }
        }
        task.resume()
    }
}
