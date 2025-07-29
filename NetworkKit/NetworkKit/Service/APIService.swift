//
//  APIService.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public final class APIService: APIServiceContract {
    private let session: URLSessionProtocol
        
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(
        using urlRequest: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder
    ) async throws -> T {
        let (data, _) = try await session.data(for: urlRequest, delegate: nil)
        return try decoder.decode(responseType.self, from: data)
    }
}
