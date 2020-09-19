//
//  NetworkManager.swift
//  Festle
//
//  Created by Евгений Уланов on 27.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible{
    var baseURL: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
}

extension URLRequestBuilder{
    var baseURL: String {
        return API.baseURL
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 10
        
        
        if (body != nil){
            request.httpBody = body
        }
        
        switch method {
        case .get:
            request.allHTTPHeaderFields = headers?.dictionary
            request = try URLEncoding.default.encode(request, with: parameters)
        case .post:
            request.allHTTPHeaderFields = headers?.dictionary
            request = try URLEncoding.default.encode(request, with: parameters)
        case .put:
            request.allHTTPHeaderFields = headers?.dictionary
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            break
        }
        return request
    }
    
    func encodeToJSON<T:Codable>(model:T)->Data{
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(model)
        return jsonData
    }
}


class NetworkManager<T: URLRequestBuilder>{
    func UpdateToken(){
        let accessToken = TokenService.shared.getAccessToken()
        let refreshToken = TokenService.shared.getRefreshToken()
        if (refreshToken != nil && accessToken != nil){
            let url = URL(string: API.baseURL)!
            var request = URLRequest(url: url.appendingPathComponent(API.Auth.refreshtoken))
            request.method = HTTPMethod.put
            request.headers = HTTPHeaders(["authorization": "Bearer " + accessToken!,
                                           "RefreshToken": refreshToken!])
            AF.request(request).responseDecodable(of: AuthResponse.self) { (response) in
                print("Request:\(response.request)\nHeaders:\(response.request?.headers)\nBody:\(response.request?.httpBody)\nCODE:\(String(describing: response.response?.statusCode))")
                switch (response.result){
                case .success(let result):
                    if(!TokenService.shared.updateTokens(model: result)){
                        print("\nError\n")
                    } else {
                        print("Tokens update")
                    }
                case .failure(let error):
                    print("\nError update tokens\n\(error.localizedDescription)")
                }
            }
            print("REQUEST:\n\(request)")
            }
    }
    
    func request<U: Codable>(service: T, decodeType: U.Type?, completion: @escaping(Result<U>)->Void) {
        self.UpdateToken()
            guard let urlRequest = service.urlRequest else { return }
            AF.request(urlRequest).responseDecodable(of: U.self) { (response) in
                print("Request:\(response.request)\nHeaders:\(response.request?.headers)\nCODE:\(String(describing: response.response?.statusCode))\nBody\(response.request?.httpBody)")
                switch response.result{
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    print("ERROR\n\n\(error.localizedDescription)\n\n\n \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func requestPhoto(username: String, image: UIImage?, completion: @escaping(AFResult<Any>)->Void){
        self.UpdateToken()
            let headers: HTTPHeaders = ["authorization": "Bearer " + TokenService.shared.getAccessToken()!,
                           "Content-type": "multipart/form-data"]
            var url = URL(string: API.baseURL)!
            url.appendPathComponent(API.User.changephoto)
            AF.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!,
                                         withName: "FormFiles",
                                         fileName: "\(username)Ava.jpg",
                                         mimeType: "image/jpg")
                }, to:url, method: .post, headers: headers).response { (response) in
                    print("\nUPDATE PHOTO CODE:\(response.response?.statusCode)\nHEADERS\(response.request?.headers)\n")
                    switch(response.result){
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        print("UPLOAD ERROR\n\n\(error.localizedDescription)\n\n")
                        completion(.failure(error))
                }
            }
        }
}

enum Result<T: Codable>{
    case success(T)
    case failure(Error)
}

enum LoginProvider: URLRequestBuilder{
    
    case login(loginModel: LoginModel)
    case loginExternal
    case register(regModel: RegisterModel)
    case registerExternal
    case logout(authorization: String)
    case refreshToken(authorization: String, refreshToken: String)
    
    var path: String{
        switch self {
        case .login:
            return API.Auth.login
        case .loginExternal:
            return API.Auth.loginexternal
        case .register:
            return API.Auth.register
        case .registerExternal:
            return API.Auth.registerexternal
        case .logout:
            return API.Auth.logout
        case .refreshToken:
            return API.Auth.refreshtoken
        }
    }
    
    var headers: HTTPHeaders?{
        switch self{
        case .logout(let authorization):
            return ["Authorization": "Bearer" + authorization]
        case .refreshToken(let authorization, let refreshToken):
            return ["Authorization":"Bearer " + authorization,
                    "RefreshToken": refreshToken]
        default:
            return nil
        }
    }
    
    var parameters: Parameters?  {
        switch self{
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .refreshToken:
            return .put
        default:
            return .post
        }
    }
    
    var body: Data?{
        switch self {
        case .login(loginModel: let loginModel):
            return encodeToJSON(model: loginModel)
        case .register(regModel: let regModel):
            return encodeToJSON(model: regModel)
        default:
            return nil
        }
    }
}

enum TourProvider: URLRequestBuilder{
    
    case createTour(model: CreateTour)
    case findTours(model: FindAPI)
    case updateTour(model: UpdateTour)
    case addPointToTour(model: AddPointToTour)
    case userTours(model: UserTours)
    case addLike(id:Int32)
    case addTourPhoto(model: AddTourPhoto)
    case addTourPointPhoto(model: AddTourPhoto)
    case removeTourPhoto(photoId: String)
    case streaming(model: StreamingModel)
    case freshtour(model: StreamingModel)
    
    var path: String{
        switch self {
        case .createTour:
            return API.Tour.createtour
        case .findTours:
            return API.Tour.findtours
        case .updateTour:
           return API.Tour.updatetour
        case .addPointToTour:
           return API.Tour.addpointtotour
        case .userTours:
            return API.Tour.userstours
        case .addLike:
            return API.Tour.addlike
        case .addTourPhoto:
            return API.Tour.addtourphoto
        case .addTourPointPhoto:
            return API.Tour.addtourpointphoto
        case .removeTourPhoto:
            return API.Tour.removetourphoto
        case .streaming:
            return API.Tour.streaming
        case .freshtour:
            return API.Tour.freshtour
        }
    }
    
    var headers: HTTPHeaders?{
        switch self{
        case .createTour, .updateTour, .addPointToTour,
             .userTours, .addLike, .addTourPhoto, .addTourPointPhoto, .removeTourPhoto:
            return ["Authorization": TokenService.shared.getAccessToken()!]
        default:
            return nil
        }
    }
    
    var parameters: Parameters?  {
        switch self{
        case .findTours(let model):
            return ["search": model.search,
                    "page" : model.page,
                    "count" : model.count]
        case .userTours(let model):
            return ["page" : model.page,
                    "count" : model.count]
        case .streaming(let model):
            return ["page" : model.page,
                    "count" : model.count]
        case .freshtour(let model):
            return ["page" : model.page,
                    "count" : model.count]
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createTour, .addPointToTour, .addLike, .addTourPhoto, .removeTourPhoto, .addTourPointPhoto:
            return .post
        case .findTours, .userTours, .streaming, .freshtour:
            return .get
        case .updateTour:
            return .put
        }
    }
    
    var body: Data?{
        switch self {
        case .createTour(model: let model):
            return encodeToJSON(model: model)
        case .findTours(model: let model):
            return encodeToJSON(model: model)
        case .updateTour(model: let model):
            return encodeToJSON(model: model)
        case .addPointToTour(model: let model):
            return encodeToJSON(model: model)
        case .userTours(model: let model):
            return encodeToJSON(model: model)
        case .addLike(id: let id):
            return encodeToJSON(model: id)
        case .addTourPhoto(model: let model):
            return encodeToJSON(model: model)
        case .addTourPointPhoto(model: let model):
            return encodeToJSON(model: model)
        case .removeTourPhoto(photoId: let photoId):
            return encodeToJSON(model: photoId)
        default:
            return nil
        }
    }
}

enum UserProvider: URLRequestBuilder{
    
    case changePassword(model: PasswordRestore)
    case changeUser(model: ChangeUserRequest)
    case changePhoto(model: ChangePhoto)
    case getUser
    case getUserByEmail(email: String)
    case addRating(model: AddRating)
    case addLike(email: String)
    case findUsers(model: FindAPI)
    case topRatedGuids(model: GetTopGuids)
    
    var path: String{
        switch self {
        case .changePassword:
            return API.User.changepassword
        case .changeUser:
            return API.User.changeuser
        case .changePhoto:
            return API.User.changephoto
        case .getUser:
            return API.User.getuser
        case .getUserByEmail:
            return API.User.getuserbyemail
        case .addRating:
            return API.User.addrating
        case .addLike:
            return API.User.addlike
        case .findUsers:
            return API.User.findusers
        case .topRatedGuids:
            return API.User.topratedguides
        }
    }
    
    var headers: HTTPHeaders?{
        switch self{
        case .getUserByEmail, .findUsers, .topRatedGuids:
            return nil
        default:
            return ["Authorization":"Bearer " + TokenService.shared.getAccessToken()!]
        }
    }
    
    var parameters: Parameters?  {
        switch self{
        case .getUserByEmail(let email):
            return ["email": email]
        case .findUsers(let model):
            return ["search": model.search,
                    "page" : model.page,
                    "count" : model.count]
        case .topRatedGuids(let model):
            return ["page" : model.page,
                    "count" : model.count]
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .changePhoto, .addLike:
            return .post
        case .getUser, .getUserByEmail, .findUsers, .topRatedGuids:
            return .get
        case .changePassword, .changeUser, .addRating:
            return .put
        }
    }
    
    var body: Data?{
        switch self {
        case .changePassword(model: let model):
            return encodeToJSON(model: model)
        case .changeUser(model: let model):
            return encodeToJSON(model: model)
        case .changePhoto(model: let model):
            return encodeToJSON(model: model)
        case .getUserByEmail(email: let email):
            return encodeToJSON(model: email)
        case .addRating(model: let model):
            return encodeToJSON(model: model)
        case .addLike(email: let email):
            return encodeToJSON(model: email)
        case .findUsers(model: let model):
            return encodeToJSON(model: model)
        default:
            return nil
        }
    }
}

struct NetworkFetcher{
    let loginFetcher = NetworkManager<LoginProvider>()
    let tourFetcher = NetworkManager<TourProvider>()
    let userFetcher = NetworkManager<UserProvider>()
}
