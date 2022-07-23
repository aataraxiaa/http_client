//
//  HTTPResult.swift
//  
//
//  Created by Pete Smith on 16/07/2022.
//

import Foundation

/// Typealias for a `Result` with a success type of `HTTPResponse` and an error type of `HTTPError`
///
/// Note: At this layer, “successful” means “we got a response”, and not “the response indicates some sort of semantic error”.
/// e.g Getting a 500 Internal Server Error or 404 Not Found response is a successful response
public typealias HTTPResult = Result<HTTPResponse, HTTPError>

/// Provides a initializer for the `HTTPResult` typealias
extension HTTPResult {
    public init(request: HTTPRequest, responseData: Data?, response: URLResponse?, error: Error?) {
        var httpResponse: HTTPResponse?
        if let r = response as? HTTPURLResponse {
            httpResponse = HTTPResponse(request: request, body: responseData ?? Data(), response: r)
        }

        if let e = error as? URLError {
            let code: HTTPError.Code
            switch e.code {
                case .badURL: code = .invalidRequest
                case .unsupportedURL: code = .invalidRequest
                default: code = .unknown
            }
            self = .failure(HTTPError(code: code, underlyingError: e))
        } else if let someError = error {
            // an error, but not a URL error
            self = .failure(HTTPError(code: .unknown, underlyingError: someError))
        } else if let r = httpResponse {
            // not an error, and an HTTPURLResponse
            self = .success(r)
        } else {
            // not an error, but also not an HTTPURLResponse
            self = .failure(HTTPError(code: .unknown, underlyingError: URLError(.unknown)))
        }
    }
}
