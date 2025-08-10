//
//  APIBuilderContract.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public protocol APIBuilderContract {
    func setPath(using path: String) -> Self
    func setMethod(using method: HTTPMethod) -> Self
    func setParameters(using parameters: HTTPParameters) -> Self
    func build() -> URLRequest
}
