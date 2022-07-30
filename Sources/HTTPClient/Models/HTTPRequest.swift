//
//  HTTPRequest.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation

/// Type representing a HTTP request
public struct HTTPRequest {

    /// HTTP method types
    public enum HTTPMethod: String {
        case get
        case post
        case put
        case delete
    }

    // Public properties
    public var path: String
    public var method: HTTPMethod
    public var headers: [String: String] = [:]

    // Requests with a body (e.g `post`)
    public var body: HTTPBody = EmptyBody()

    public init(path: String, method: HTTPMethod = .get) {
        self.method = method
        self.path = path
    }
}
