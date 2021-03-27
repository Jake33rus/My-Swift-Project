//
//  Collection.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            if indices.contains(index),
                let newValue = newValue {
                self[index] = newValue
            }
        }
    }
}
