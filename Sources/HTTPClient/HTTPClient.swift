//
//  HTTPClient.swift
//
//
//  Created by Pete Smith on 16/07/2022.
//

import Foundation

/// A type which loads `HTTPRequest`s and returns a `HTTPResult`. Internally uses `URLSession` to make HTTP requests.
public struct HTTPClient: HTTPLoading {

    /// Host which will be the target of HTTP requests
    public let host: String

    /// Initializer for `HTTPClient`
    /// - Parameter host: Host which will be the target of HTTP requests. Must be of the format `api.citybik.es`
    public init(host: String) {
        self.host = host
    }

    private let session = URLSession.shared

    /// Loads `HTTPRequest`s and returns a `HTTPResult`. Internally uses `URLSession` to make HTTP requests.
    /// - Parameters:
    ///   - request: `HTTPRequest` to make
    ///   - completion: A `HTTPResult` value
    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {

        // Construct URL
        guard let url = urlFor(request) else {
            completion(.failure(HTTPError(code: .invalidRequest, underlyingError: URLError(.badURL))))
            return
        }

        // Construct the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        // Add any custom HTTP headers
        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }

        // Add a body to the request if it exists
        if !request.body.isEmpty {
            // Body headers
            for (header, value) in request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }

            // Encode the body
            do {
                urlRequest.httpBody = try request.body.encode()
            } catch {
                completion(.failure(HTTPError(code: .unknown, underlyingError: URLError(.unknown))))
                return
            }
        }

        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            let result = HTTPResult(request: request, responseData: data, response: response, error: error)
            completion(result)
        }

        dataTask.resume()
    }
}

private extension HTTPClient {

    func urlFor(_ request: HTTPRequest) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = request.path
        return components.url
    }
}
