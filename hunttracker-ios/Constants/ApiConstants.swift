//
//  ApiConstants.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 03/09/2020.
//

import Foundation

struct ApiConstants {
    static var baseUrl = URL(string: "https://hunttracker.herokuapp.com")!
    static var loginUrl = ApiConstants.baseUrl.appendingPathComponent("/api/auth")
    static var resetPasswordUrl = ApiConstants.baseUrl.appendingPathComponent("/api/users/send-reset-password-email")
}
