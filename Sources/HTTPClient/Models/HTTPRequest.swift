//
//  File.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation

public struct HTTPRequest<Response> {

    public enum HTTPMethod {
        case get
        case post
        case put
        case delete
    }

    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]
    public var body: Data?
    public let decode: (HTTPResponse) throws -> Response
    private var urlComponents = URLComponents()

    public init(decode: @escaping (HTTPResponse) throws -> Response) {
        urlComponents.scheme = "https"
        self.decode = decode
    }
}

extension HTTPRequest where Response: Decodable {
    public init() {
        self.init(decode: { response in
            let decodedResponse = try JSONDecoder().decode(Response.self, from: response.body!)
            return decodedResponse
        })
    }
}
