//
//  GetText.swift
//  hunttracker-ios
//
//  Created by Vegard Gillestad on 27/07/2021.
//

import Foundation

func gettext(_ key: String) -> String {
    let localized = NSLocalizedString(key, comment: "")
    return localized == ""
        ? key
        : localized
}
