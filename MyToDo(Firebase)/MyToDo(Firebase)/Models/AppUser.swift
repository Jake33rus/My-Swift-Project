//
//  User.swift
//  MyToDo(Firebase)
//
//  Created by Евгений Уланов on 06.05.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import Firebase

struct AppUser {
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
