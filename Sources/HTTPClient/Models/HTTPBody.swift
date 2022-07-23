//
//  HTTPBody.swift
//  
//
//  Created by Pete Smith on 16/07/2022.
//

import Foundation

/// Generalized type that provides body`Data` for a HTTP request
public protocol HTTPBody {
    var isEmpty: Bool { get }
    var additionalHeaders: [String: String] { get }
    func encode() throws -> Data
}

// Default implementation
extension HTTPBody {
    public var isEmpty: Bool { false }
    public var additionalHeaders: [String: String] { [:] }
}

/// Type represening an empty HTTP body
public struct EmptyBody: HTTPBody {
    public let isEmpty = true
    public func encode() throws -> Data { Data() }
}

/// Type represening a `Data` HTTP body
public struct DataBody: HTTPBody {
    private let data: Data

    public var isEmpty: Bool { data.isEmpty }
    public var additionalHeaders: [String : String]

    public init(_ data: Data, additionalHeaders: [String: String] = [:]) {
        self.data = data
        self.additionalHeaders = additionalHeaders
    }

    public func encode() throws -> Data { data }
}

/// Type represening a JSON HTTP body
public struct JSONBody: HTTPBody {
    public var isEmpty = false
    public var additionalHeaders = [
        "Content-Type": "application/json; charset=utf-8"
    ]

    private let encodeJSON: () throws -> Data

    public init<T: Encodable>(_ value: T, encoder: JSONEncoder = JSONEncoder()) {
        self.encodeJSON = { try encoder.encode(value) }
    }

    public func encode() throws -> Data {
        return try encodeJSON()
    }
}
