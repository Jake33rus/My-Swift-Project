//
//  String+extensions.swift
//  ToDoApp(UnitTests)
//
//  Created by Евгений Уланов on 15.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation

extension String {
    var percentEncoded: String{
        let allowedCharcters = CharacterSet(charactersIn: "~!@#$%^&*()-+=[]\\{},.?<>").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharcters) else {
            fatalError()
        }
        return encodedString
    }
}
