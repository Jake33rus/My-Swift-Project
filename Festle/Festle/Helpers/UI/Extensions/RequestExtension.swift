//
//  ResponseExtension.swift
//  Festle
//
//  Created by Евгений Уланов on 02.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import Alamofire

public extension DataRequest {

    @discardableResult
    public func log(level: LogLevel = .simple) -> Self {
        self.logRequest(level: level)
        return self.logResponse(level: level)
    }

    @discardableResult
    public func logRequest(level: LogLevel = .simple) -> Self {
        guard level != .none else {
            return self
        }
        guard
            let method = self.request?.httpMethod,
            let url = self.request?.url else {
            return self
        }
        var message = "[REQUEST] \(method) \(url)"
        if level == .verbose {
            if let headers = self.request?.allHTTPHeaderFields {
                for header in headers {
                    message += "\n\(header.key): \(header.value)"
                }
            }
            if let data = self.request?.httpBody,
                let body = String(data: data, encoding: .utf8) {
                message += "\n\(body)"
            }
        }

        print(message)

        return self
    }

    @discardableResult
    public func logResponse(level: LogLevel = .simple) -> Self {
        guard level != .none else {
            return self
        }
        return self.response(completionHandler: {
            guard
                let method = $0.request?.httpMethod,
                let url = $0.request?.url else {
                return
            }

            var message = "[RESPONSE] \(method) \($0.response?.statusCode ?? -1) \(url) \(String(format: "%.3fms", $0.timeline.requestDuration * 1000))"

            if let err = $0.error?.localizedDescription {
                message += " [!] \(err)"
            }

            if level == .verbose {
                if let headers = $0.response?.allHeaderFields {
                    for header in headers {
                        message += "\n\(header.key): \(header.value)"
                    }
                }
                if let data = $0.data,
                    let body = String(data: data, encoding: .utf8) {
                    if body.count > 0 {
                        message += "\n\(body)"
                    }
                }
            }

            print(message)
        })
    }
}
