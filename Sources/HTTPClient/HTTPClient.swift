import Foundation

public struct HTTPClient {

    let host: String

    public func request<Response>(_: HTTPRequest<Response>, completion: (Result<Response, Error>) -> Void) {

//        let urlRequest = URLRequest()

        let request = HTTPRequest<String>()

//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            // Do something
//        }
        
    }
}
