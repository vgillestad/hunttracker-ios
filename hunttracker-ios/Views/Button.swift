//
//  Button.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 03/09/2020.
//

import Foundation
import UIKit

class Button : UIButton {
    
    private let activityIndicator = UIActivityIndicatorView()
    
    var isFecthing:Bool = false {
        didSet {
            isFecthing
                ? activityIndicator.startAnimating()
                : activityIndicator.stopAnimating()
            isEnabled = !isFecthing
        }
    }
    
    private func setup() {
        backgroundColor =  UIColor(red: 96/255, green: 183/255, blue: 96/255, alpha: 1)
        addSubview(activityIndicator)
        setConstraints()
    }
    
    private func setConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }
    
    override init(frame: CGRect) { super.init(frame: frame); setup() }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }
}
