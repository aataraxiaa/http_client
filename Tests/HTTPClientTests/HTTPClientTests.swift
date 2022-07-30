import XCTest
@testable import HTTPClient

final class HTTPClientTests: XCTestCase {

    let sut = HTTPClient(host: "api.citybik.es")

    func testInvalidURL() throws {
        // Given
        let getRequest = HTTPRequest(path: "INVALID_PATH")
        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: getRequest) { result in

            if case let .failure(error) = result {
                XCTAssertEqual(error.code, .invalidRequest)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
    
    func testGetSuccess() throws {
        // Given
        let getRequest = HTTPRequest(path: HTTPRequest.cityBikPath("dublinbikes"))
        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: getRequest) { result in

            if case let .success(value) = result {
                XCTAssertEqual(value.status, .success)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testGetWithHeaders() throws {
        // Given
        var getRequest = HTTPRequest(path: HTTPRequest.cityBikPath("dublinbikes"))
        let headers = ["User-Agent": "Xcode"]
        getRequest.headers = headers

        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: getRequest) { result in

            if case let .success(value) = result {
                XCTAssertEqual(value.request.headers, headers)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testPostWithDataBody() throws {
        // Given
        var postRequest = HTTPRequest(path: HTTPRequest.cityBikPath("dublinbikes"), method: .post)
        let body = DataBody(Data([1,2,3]))
        postRequest.body = body

        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: postRequest) { result in

            if case let .success(value) = result {
                XCTAssertEqual(value.request.body as! DataBody, body)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testPostWithDataBodyHeaders() throws {
        // Given
        var postRequest = HTTPRequest(path: HTTPRequest.cityBikPath("dublinbikes"), method: .post)
        let headers = ["Content-Length": "3"]
        let body = DataBody(Data([1,2,3]), additionalHeaders: headers)

        postRequest.body = body

        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: postRequest) { result in

            if case let .success(value) = result {
                XCTAssertEqual(value.request.body.additionalHeaders, headers)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testPostWithDataBodyError() throws {
        // Given
        var postRequest = HTTPRequest(path: HTTPRequest.cityBikPath("dublinbikes"), method: .post)
        let body = ErrorBody()

        postRequest.body = body

        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: postRequest) { result in

            if case let .failure(error) = result {
                XCTAssertEqual(error.code, .unknown)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }

    func testGetClientError() throws {
        // Given
        let getRequest = HTTPRequest(path: HTTPRequest.cityBikPath("invalidpath"))
        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: getRequest) { result in
            if case let .success(value) = result {
                XCTAssertEqual(value.status, .clientErrors)
            } else {
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
}
