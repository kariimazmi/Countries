//
//  APIService.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public final class APIService: APIServiceContract {
    public static let shared = APIService()
    private let session: URLSession
    
    private init() {
        self.session = .shared
    }
    
    public func request<T: Decodable>(
        using urlRequest: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder
    ) async throws -> T {
        let (data, _) = try await session.data(for: urlRequest)
        return try decoder.decode(responseType.self, from: data)
    }
}
