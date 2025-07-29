//
//  MockURLSession.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

@testable import NetworkKit
import Foundation

final class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        let url = request.url ?? URL(string: "https://example.com")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        return (mockData ?? Data(), response)
    }
}
