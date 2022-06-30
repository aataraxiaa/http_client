//
//  File.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation

public class HTTPRequest {

    public enum HTTPMethod {
        case get
        case post
        case put
        case delete
    }

    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]
    public var body: Data?
    private var urlComponents = URLComponents()

    public init() {
        urlComponents.scheme = "https"
    }
}
