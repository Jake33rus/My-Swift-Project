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
}


class NetworkManager<T: URLRequestBuilder>{
    func request<U: Codable>(service: T, decodeType: U.Type, completion: @escaping(Result<U>)->Void) {
        guard let urlRequest = service.urlRequest else { return }
        AF.request(urlRequest).responseDecodable(of: U.self) { (response) in
            switch response.result{
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
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
            return ["Authorization": authorization]
        case .refreshToken(let authorization, let refreshToken):
            return ["Authorization": authorization,
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
            let encoder = JSONEncoder()
            let jsonData = try! encoder.encode(loginModel)
            return jsonData
        case .register(regModel: let regModel):
            let encoder = JSONEncoder()
            let jsonData = try! encoder.encode(regModel)
            return jsonData
        default:
            return nil
        }
    }
    
}
