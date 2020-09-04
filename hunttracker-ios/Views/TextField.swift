//
//  TextField.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 03/09/2020.
//

import Foundation
import UIKit

class TextField : UITextField {
    private func setup() {
        borderStyle = .roundedRect
        layer.borderColor = UIColor.gray.cgColor
    }
    
    override init(frame: CGRect) { super.init(frame: frame); setup() }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }
}
