//
//  AlertViewController.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 14/09/2020.
//

import Foundation
import UIKit

class AlertViewController : UIViewController {
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, onConfirm: nil)
    }
    
    func showAlert(title: String, message: String, onConfirm: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
           onConfirm?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showUnexpectedErrorAlert() {
        showAlert(title: gettext("unexpected-error-title"), message: gettext("unexpected-error-message"))
    }
}
