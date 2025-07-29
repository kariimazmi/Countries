//
//  APIBuilder.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public class APIBuilder: APIBuilderContract {
    private(set) var urlRequest: URLRequest
    
    public init() {
        guard let urlString = Bundle.main.infoDictionary?["hostname"] as? String,
              let url = URL(string: urlString)
        else {
            fatalError("Could not create URL")
        }
        
        self.urlRequest = .init(url: url)
    }
    
    @discardableResult
    open func setPath(using path: String) -> Self {
        urlRequest.url = urlRequest.url?.appendingPathComponent(path)
        return self
    }
    
    @discardableResult
    open func setMethod(using method: HTTPMethod) -> Self {
        urlRequest.httpMethod = method.rawValue
        return self
    }
    
    @discardableResult
    open func setParameters(using parameters: HTTPParameters) -> Self {
        switch parameters {
        case .query(let params):
            let queryParams = params.map { pair in
                var value = pair.value
                if let array = value as? [CustomStringConvertible] {
                    value = array.map { "\($0)" }.joined(separator: ",")
                }
            
                return URLQueryItem(name: pair.key, value: "\(value)")
            }
            
            if let url = urlRequest.url {
                var components = URLComponents(string: url.absoluteString)
                components?.queryItems = queryParams
                
                urlRequest.url = components?.url
            }
        }
        
        return self
    }
  
    open func build() -> URLRequest {
        guard let url = urlRequest.url, !url.pathComponents.isEmpty else {
            fatalError("API should contain at least one path.")
        }
        
        urlRequest.setValue(HTTPContentType.json, forHTTPHeaderField: HTTPHeader.contentType)
        
        return urlRequest
    }
}
