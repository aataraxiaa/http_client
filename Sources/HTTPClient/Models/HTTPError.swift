//
//  HTTPError.swift
//  
//
//  Created by Pete Smith on 30/06/2022.
//

import Foundation

/// Type which encapsulates an underlying error and exposes an error code
public struct HTTPError: Error {

    /// HTTP error codes
    public enum Code {
        case invalidRequest
        case cannotConnect
        case cancelled
        case insecureConnection
        case invalidResponse
        case unknown
    }
    
    public let code: Code
    public let underlyingError: Error
}
