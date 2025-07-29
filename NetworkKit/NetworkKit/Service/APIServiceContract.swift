//
//  APIServiceContract.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public protocol APIServiceContract {
    func request<T: Decodable>(
        using urlRequest: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder
    ) async throws -> T
}

public extension APIServiceContract {
    func request<T: Decodable>(
        using urlRequest: URLRequest,
        responseType: T.Type
    ) async throws -> T {
        try await request(
            using: urlRequest,
            responseType: responseType,
            decoder: .init()
        )
    }
}
