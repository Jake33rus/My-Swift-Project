//
//  Localized.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import Foundation

typealias Localized = String

extension Localized {

    /// Localize string key
    var localized: String {
        return NSLocalizedString(self, bundle: .module, comment: self)
    }

    /// Localize plural string key
    func localized<T>(_ count: T) -> String {
        return String.localizedStringWithFormat(localized, count as! CVarArg)
    }
}
