//
//  Emojies.swift
//  Checklists
//
//  Created by Евгений Уланов on 24.09.2020.
//

import Foundation
import UIKit

struct Emojies{
    let size: Int
    let emojies: [UIImage]
    init(size:Int) {
        self.size = size
        self.emojies = ["🏆".image(resize: size)!,
                        "🧘‍♂️".image(resize: size)!,
                        "🍻".image(resize: size)!,
                        "🍔".image(resize: size)!,
                        "🥑".image(resize: size)!,
                        "🍿".image(resize: size)!,
                        "☕️".image(resize: size)!,
                        "🎮".image(resize: size)!,
                        "🎬".image(resize: size)!,
                        "🏊".image(resize: size)!,
                        "🎹".image(resize: size)!,
                        "💸".image(resize: size)!,
                        "💊".image(resize: size)!,
                        "📚".image(resize: size)!,
                        "🎉".image(resize: size)!,
                        "🙂".image(resize: size)!,
                        "🤬".image(resize: size)!,
                        "🙏".image(resize: size)!,
                        "✈️".image(resize: size)!,
                        "💻".image(resize: size)!,
                        "🚗".image(resize: size)!,
                        "🪒".image(resize: size)!,
                        "🚭".image(resize: size)!,
                        "🚬".image(resize: size)!,
                        "⛔️".image(resize: size)!,
                        "✅".image(resize: size)!,
                        "❤️".image(resize: size)!,
                        
]
    }
}
