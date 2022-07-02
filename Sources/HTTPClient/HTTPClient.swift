import Foundation


public struct Request<Response> {
    public let underlyingRequest: HTTPRequest
    public let decode: (HTTPResponse) throws -> Response

    public init(underlyingResponse: HTTPRequest, decode: @escaping (HTTPResponse) throws -> Response) {
        self.underlyingRequest = underlyingResponse
        self.decode = decode
    }
}

extension Request where Response: Decodable {
    public init(underlyingRequest: HTTPRequest) {
        self.init(underlyingResponse: underlyingRequest, decode: { response in
            let decodedResponse = try JSONDecoder().decode(Response.self, from: response.body!)
            return decodedResponse
        })
    }
}

public struct HTTPClient {
    

    public func request() {

    }
}
