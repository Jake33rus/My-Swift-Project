//
//  API.swift
//  Festle
//
//  Created by Евгений Уланов on 26.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation

struct API {
    static let baseURL = "https://www.showingo.ru/api"
    static let photoURL = "https://www.showingo.ru/photo/"
    
    struct Auth {
        static let login = "/Auth/login"
        static let loginexternal = "/Auth/loginexternal"
        static let register = "/Auth/regsiter"
        static let registerexternal = "/Auth/regsiterexternal"
        static let logout = "/Auth/logout"
        static let refreshtoken = "/Auth/refreshtoken"
    }
    
    struct Tour {
        static let createtour = "/Tour/createtour"
        static let findtours = "/Tour/findtours"
        static let updatetour = "/Tour/updatetour"
        static let addpointtotour = "/Tour/addpointtotour"
        static let userstours = "/Tour/userstours"
        static let addlike = "/Tour/addlike"
        static let addtourphoto = "/Tour/addtourphoto"
        static let addtourpointphoto = "/Tour/addtourpointphoto"
        static let removetourphoto = "/Tour/removetourphoto"
        static let streaming = "/Tour/streaming"
        static let freshtour = "/Tour/freshtour"
    }
    
    struct  User {
        static let changepassword = "/User/changepassword"
        static let changeuser = "/User/changeuser"
        static let changephoto = "/User/changephoto"
        static let getuser = "/User/getuser"
        static let getuserbyemail = "/User/getuserbyemail"
        static let addrating = "/User/addrating"
        static let addlike = "/User/addlike"
        static let findusers = "/User/findusers"
        static let topratedguides = "/User/topratedguides"
    }
}
