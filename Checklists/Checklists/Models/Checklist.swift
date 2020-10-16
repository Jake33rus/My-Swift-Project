//
//  Checklist.swift
//  Checklists
//
//  Created by Евгений Уланов on 24.09.2020.
//

import Foundation
import UIKit

struct Checklist{
    var name: String
    var desc: String
    var startDate: Date?
    var finishDate: Date?
    var duration: Int = 7
    var results: [Bool]?
    var icon: UIImage
    var isComplite: Bool = false
}

struct Examples{
    let actuals: (String, [Checklist]) = ("Актуальные", [Checklist(name: "Трезвенник",
                                          desc: "Отмечайте те дни, когда выпиваете",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🍻".image(resize: 60)!),
                                Checklist(name: "Фастфуд",
                                          desc: "Отмечайте те дни, когда вы не питались фастфудом",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🍔".image(resize: 60)!),
                                Checklist(name: "Развитие",
                                          desc: "Отмечайте те дни, когда вы занимались своим развитием",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🧠".image(resize: 60)!),
                                Checklist(name: "Спорт",
                                          desc: "Отмечайте те дни, когда вы занимались спортом",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🏆".image(resize: 60)!)])
    
    let badHabits: (String, [Checklist]) = ("Плохие привычки", [Checklist(name: "Трезвенник",
                                          desc: "Отмечайте те дни, когда выпиваете",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🍻".image(resize: 60)!),
                                Checklist(name: "Фастфуд",
                                          desc: "Отмечайте те дни, когда вы не питались фастфудом",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🍔".image(resize: 60)!),
                                Checklist(name: "Игры",
                                          desc: "Отмечайте те дни, когда вы играли слишком много",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🎮".image(resize: 60)!),
                                Checklist(name: "Курение",
                                          desc: "Отмечайте те дни, когда вы не курили",
                                          startDate: nil,
                                          finishDate: nil,
                                          results: nil,
                                          icon: "🚭".image(resize: 60)!)])
    
    let selfDevelopment: (String, [Checklist]) = ("Саморазвитие", [Checklist(name: "Чтение",
                                                  desc: "Отмечайте те дни, когда вы читали более 20 страниц",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "📚".image(resize: 60)!),
                                        Checklist(name: "Киноман",
                                                  desc: "Отмечайте те дни, когда вы смотрели фильм",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "🍿".image(resize: 60)!),
                                        Checklist(name: "Жаворонок",
                                                  desc: "Отмечайте те дни, когда вы рано вставали",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "⏰".image(resize: 60)!),
                                        Checklist(name: "Музыкант",
                                                  desc: "Отмечайте те дни, когда вы занимались музыкой",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "🎹".image(resize: 60)!),
                                        Checklist(name: "Полиглот",
                                                  desc: "Отмечайте те дни, когда вы изучили более 10 иностранных слов",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "🇬🇧".image(resize: 60)!)])
    let health: (String, [Checklist]) = ("Здоровье", [Checklist(name: "Здоровое питане",
                                                  desc: "Отмечайте те дни, когда вам удалось питаться правильно",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "🥦".image(resize: 60)!),
                                        Checklist(name: "Ммм...овощи",
                                                  desc: "Отмечайте те дни, когда вы ели овощи",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "🥗".image(resize: 60)!),
                                        Checklist(name: "Кофеман",
                                                  desc: "Отмечайте те дни, когда вы не пили кофе",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "☕️".image(resize: 60)!),
                                        Checklist(name: "Сладкоежка",
                                                  desc: "Отмечайте те дни, когда вы переборщили с сладким",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "🍬".image(resize: 60)!),
                                        Checklist(name: "Лекарства",
                                                  desc: "Отмечайте день когда вы принимали лекарства",
                                                  startDate: nil,
                                                  finishDate: nil,
                                                  results: nil,
                                                  icon: "💊".image(resize: 60)!)])
    
}
