import Foundation

public typealias HTTPResult = Result<HTTPResponse, HTTPError>

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
            self = .failure(HTTPError(code: .invalidResponse, underlyingError: error))
        }
    }
}

/// Abstract interface
public protocol HTTPLoading {

    /// Host URL (i.e base URL)
    var host: String { get }

    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)
}

public struct HTTPClient: HTTPLoading {

    public let host: String

    public init(host: String) {
        self.host = host
    }

    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {

        let httpUrlResponse = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let response = HTTPResponse(request: request, body: nil, response: httpUrlResponse!)
        completion(.success(response))

        guard let url = urlFor(request) else {
            // we couldn't construct a proper URL out of the request's URLComponents
//            completion(.failure(HTTPError(code: .invalidRequest, underlyingError: )))
            return
        }

                // construct the URLRequest
                var urlRequest = URLRequest(url: url)
                urlRequest.httpMethod = request.method.rawValue

                // copy over any custom HTTP headers
                for (header, value) in request.headers {
                    urlRequest.addValue(value, forHTTPHeaderField: header)
                }

//                if request.body?.isEmpty == false {
//                    // if our body defines additional headers, add them
//                    for (header, value) in request.body.additionalHeaders {
//                        urlRequest.addValue(value, forHTTPHeaderField: header)
//                    }
//
//                    // attempt to retrieve the body data
//                    do {
//                        urlRequest.httpBody = try request.body.encode()
//                    } catch {
//                        // something went wrong creating the body; stop and report back
//                        completion(.failure(...))
//                        return
//                    }
//                }

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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



        return nil
    }
}
