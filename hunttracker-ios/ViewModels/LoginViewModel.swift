//
//  LoginViewModel.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 03/09/2020.
//

import Foundation
import Combine

protocol LoginCoordinatorDelegate : class {
    func didLogin(token:String)
}

protocol LoginViewDelegate : class {
    func showIsFetching(_ isFeching:Bool)
    func showAlert(title:String, message:String)
}

class LoginViewModel {
    
    var isFetching:Bool = false {
        didSet { viewDelegate?.showIsFetching(isFetching) }
    }
    
    private weak var coordinatorDelegate:LoginCoordinatorDelegate?
    weak var viewDelegate:LoginViewDelegate?
    
    init(coordinatorDelegate:LoginCoordinatorDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func didTapLogin(email:String?, password:String?) {
        if let email = email, let password = password {
            isFetching = true
            var request = URLRequest(url: URL(string: ApiConstants.loginUrl.absoluteString)!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: ["email":email, "password":password], options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    self?.isFetching = false
                }
                
                if
                    let url = response?.url,
                    let httpResponse = response as? HTTPURLResponse,
                    let fields = httpResponse.allHeaderFields as? [String: String],
                    let token = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url).first(where: {$0.name == "token"})?.value {
                    DispatchQueue.main.async {
                        self?.coordinatorDelegate?.didLogin(token: token)
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
    
    func didTapRegister() {
        self.viewDelegate?.showAlert(title: "Not available", message: "Unfortunantly this feature us not available in the app yet. Please visit \(ApiConstants.baseUrl.absoluteString) to register.")
    }
}
