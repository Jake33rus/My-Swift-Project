//
//  String+Extensions.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

extension String {
    
    func width(attributes: [NSAttributedString.Key : Any]) -> CGFloat {
        var lineHeight: CGFloat = 0
        if let font = attributes[NSAttributedString.Key.font] as? UIFont {
            lineHeight = font.lineHeight
        } else {
            assertionFailure()
        }
        
        return self.width(withConstrainedHeight: lineHeight, attributes: attributes)
    }
    
    func width(withConstrainedHeight height: CGFloat, attributes: [NSAttributedString.Key : Any]) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(boundingBox.width)
    }
    
    func attributedStringWith(kern: CGFloat) -> NSAttributedString {
        return mutableAttributedStringWith(kern: kern)
    }
    
    func mutableAttributedStringWith(kern: CGFloat) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.kern: kern])
    }
}

extension Optional where Wrapped == String {
    
    var unnil: String { self ?? "" }
}

extension String {
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
}

extension String {
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self

        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1

            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }

        return returnValue
    }
}

extension String {
    func truncate(to length: Int, addEllipsis: Bool = false) -> String  {
        if length > count { return self }

        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]

        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }
}

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}  
