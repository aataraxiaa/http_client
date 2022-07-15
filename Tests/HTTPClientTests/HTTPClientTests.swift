import XCTest
@testable import HTTPClient

final class HTTPClientTests: XCTestCase {

    let sut = HTTPClient(host: "swapi.dev/api/")
    
    func testGet() throws {
        // Given
        let getPersonRequest = HTTPRequest(path: "people/1")
        let expectation = XCTestExpectation(description: "Fetch a person asynchoronously")

        // When
        sut.load(request: getPersonRequest) { result in
            // Assert here
            guard case let .success(value) = result else {
                XCTFail()
                return
            }

            XCTAssertEqual(value.status, .success)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}
