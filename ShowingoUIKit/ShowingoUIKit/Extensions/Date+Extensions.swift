//
//  Date+Extensions.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import Foundation

extension Date {
    func days(between otherDate: Date) -> Int {
        let calendar = Calendar.current

        let startOfSelf = calendar.startOfDay(for: self)
        let startOfOther = calendar.startOfDay(for: otherDate)
        let components = calendar.dateComponents([.day], from: startOfSelf, to: startOfOther)

        return abs(components.day ?? 0)
    }
}
