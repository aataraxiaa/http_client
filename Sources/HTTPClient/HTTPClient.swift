//
//  HTTPClient.swift
//
//
//  Created by Pete Smith on 16/07/2022.
//

import Foundation

public struct HTTPClient: HTTPLoading {

    public let host: String

    public init(host: String) {
        self.host = host
    }

    private let session = URLSession.shared

    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {

        guard let url = urlFor(request) else {
            // we couldn't construct a proper URL out of the request's URLComponents
            completion(.failure(HTTPError(code: .invalidRequest, underlyingError: BaseError.invalidURL)))
            return
        }

        // construct the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        // copy over any custom HTTP headers
        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }

        if !request.body.isEmpty {
            // if our body defines additional headers, add them
            for (header, value) in request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }

            // attempt to retrieve the body data
            do {
                urlRequest.httpBody = try request.body.encode()
            } catch {
                // something went wrong creating the body; stop and report back
                completion(.failure(HTTPError(code: .unknown, underlyingError: BaseError.unknown)))
                return
            }
        }

        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            // construct a Result<HTTPResponse, HTTPError> out of the triplet of data, url response, and url error
            let result = HTTPResult(request: request, responseData: data, response: response, error: error)
            completion(result)
        }

        // off we go!
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
