//
//  File.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation

public struct HTTPResponse {

    public enum HTTPStatus: Int {
        case info
        case success
        case redirection
        case clientErrors
        case serverErrors

        public init(rawValue: Int) {
            switch rawValue {
            case 100..<200:
                self = .info
            case 200..<300:
                self = .success
            case 300..<400:
                self = .redirection
            case 400..<500:
                self = .clientErrors
            case 500..<600:
                self = .serverErrors
            default:
                self = .success
            }
        }
    }

    public let request: HTTPRequest
    public let body: Data?
    public let response: HTTPURLResponse

    public var status: HTTPStatus {
        HTTPStatus(rawValue: response.statusCode)
    }

    public var message: String {
        HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
    }

    public var headers: [AnyHashable: Any] {
        response.allHeaderFields
    }
}
