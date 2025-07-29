//
//  MockAPIService.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries
@testable import NetworkKit

final class MockAPIService: APIServiceContract {
    var requestCalled = false
    var mockResponse: Any?

    func request<T>(
        using urlRequest: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder
    ) async throws -> T where T : Decodable {
        requestCalled = true

        guard let response = mockResponse as? T else {
            fatalError("Mock response not set or of wrong type")
        }

        return response
    }
}
