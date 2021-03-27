//
//  Comparable + clamped.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import Foundation

public extension Comparable {
    /// Возвращает значение ограниченное границами диапазона
    func clamped(to r: ClosedRange<Self>) -> Self {
        let min = r.lowerBound, max = r.upperBound
        return self < min ? min : (max < self ? max : self)
    }
}
