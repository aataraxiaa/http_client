//
//  HTTPResponseTests.swift
//  
//
//  Created by Pete Smith on 02/07/2022.
//

import XCTest
@testable import HTTPClient

final class HTTPResponseTests: XCTestCase {

    private var sut: HTTPResponse! = nil

    func testStatusInfo() throws {

        // Given
        let sut = HTTPResponse(body: nil, response: .info)
        let expected = HTTPResponse.HTTPStatus.info

        // When
        let actual = sut.status

        // Then
        XCTAssertEqual(expected, actual)
    }

    func testStatusSuccess() throws {

        // Given
        let sut = HTTPResponse(body: nil, response: .success)
        let expected = HTTPResponse.HTTPStatus.success

        // When
        let actual = sut.status

        // Then
        XCTAssertEqual(expected, actual)
    }

    func testStatusRedirect() throws {

        // Given
        let sut = HTTPResponse(body: nil, response: .redirect)
        let expected = HTTPResponse.HTTPStatus.redirection

        // When
        let actual = sut.status

        // Then
        XCTAssertEqual(expected, actual)
    }

    func testStatusClientError() throws {

        // Given
        let sut = HTTPResponse(body: nil, response: .clientError)
        let expected = HTTPResponse.HTTPStatus.clientErrors

        // When
        let actual = sut.status

        // Then
        XCTAssertEqual(expected, actual)
    }

    func testStatusServerError() throws {

        // Given
        let sut = HTTPResponse(body: nil, response: .serverError)
        let expected = HTTPResponse.HTTPStatus.serverErrors

        // When
        let actual = sut.status

        // Then
        XCTAssertEqual(expected, actual)
    }

    

}
