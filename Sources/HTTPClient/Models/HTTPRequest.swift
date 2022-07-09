//
//  File.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation


/// Type representing a HTTP request
public struct HTTPRequest<Response> {

    /// HTTP method types
    public enum HTTPMethod {
        case get
        case post
        case put
        case delete
    }

    // Public properties
    public var path: String
    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]

    // Requests with a body (e.g `post`)
    public var body: Data?

    // Decoding
    public let decode: (HTTPResponse) throws -> Response

    // Private properties
    private var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        return components
    }()

    public init(path: String, decode: @escaping (HTTPResponse) throws -> Response) {
        self.path = path
        self.decode = decode
    }
}

extension HTTPRequest where Response: Decodable {
    public init(path: String) {
        self.init(path: path, decode: { response in
            let decodedResponse = try JSONDecoder().decode(Response.self, from: response.body!)
            return decodedResponse
        })
    }
}
