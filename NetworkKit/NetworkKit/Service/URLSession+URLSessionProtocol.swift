//
//  URLSessionProtocol.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public protocol URLSessionProtocol {
    func data(
        for request: URLRequest,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
}
