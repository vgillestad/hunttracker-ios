//
//  LoginNavigationController.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 14/09/2020.
//

import Foundation
import UIKit

class LoginNavigationController : UINavigationController {
    
    private func setup() {
        navigationBar.isTranslucent = true
        navigationBar.tintColor = UIColor.white
        navigationBar.barStyle = .black
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    override init(rootViewController: UIViewController) { super.init(rootViewController: rootViewController); setup() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); setup() }
}
