import XCTest
@testable import HTTPClient

final class HTTPClientTests: XCTestCase {

    let sut = HTTPClient(host: "api.citybik.es")
    
    func testGetSuccess() throws {
        // Given
        let getRequest = HTTPRequest(path: HTTPRequest.cityBikPath("dublinbikes"))
        let expectation = XCTestExpectation(description: "Fetch bike share information asynchoronously")

        // When
        sut.load(request: getRequest) { result in
            // Assert here
            guard case let .success(value) = result else {
                XCTFail()
                return
            }

            XCTAssertEqual(value.status, .success)

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
            // Assert here
            guard case let .success(value) = result else {
                XCTFail()
                return
            }

            XCTAssertEqual(value.status, .clientErrors)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 20)
    }
}
