//
//  File.swift
//  
//
//  Created by Pete Smith on 02/07/2022.
//

import Foundation
@testable import HTTPClient

extension HTTPRequest {
    static let basicGet = HTTPRequest(path: "/api/test")

    static func cityBikPath(_ path: String) -> String {
        "/v2/networks/\(path)"
    }
}

extension URL {
    static let mock = URL(string: "https://www.google.com")!
}

extension HTTPURLResponse {
    static let info = HTTPURLResponse(url: .mock, statusCode: 100, httpVersion: nil, headerFields: nil)!

    static let success = HTTPURLResponse(url: .mock, statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let redirect = HTTPURLResponse(url: .mock, statusCode: 300, httpVersion: nil, headerFields: nil)!

    static let clientError = HTTPURLResponse(url: .mock, statusCode: 400, httpVersion: nil, headerFields: nil)!

    static let serverError = HTTPURLResponse(url: .mock, statusCode: 500, httpVersion: nil, headerFields: nil)!
}
