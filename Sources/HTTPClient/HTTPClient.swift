import Foundation


/// Abstract interface of a HTTPClient
public protocol HTTPClientProtocol {

    /// Host URL (i.e base URL)
    var host: String { get }

    func request<Response>(_: HTTPRequest<Response>, completion: (Result<Response, Error>) -> Void)
}

public struct HTTPClient: HTTPClientProtocol {

    public let host: String

    public init(host: String) {
        self.host = host
    }

    public func request<Response>(_: HTTPRequest<Response>, completion: (Result<Response, Error>) -> Void) {
        URLSession.shared.da
    }
}
