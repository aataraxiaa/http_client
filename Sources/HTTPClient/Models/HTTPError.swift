//
//  HTTPError.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation

public struct HTTPError: Error {
    
    public let code: Code
    public let underlyingError: Error

    public enum Code {
        case invalidRequest
        case cannotConnect
        case cancelled
        case insecureConnection
        case invalidResponse
        case unknown
    }
}
