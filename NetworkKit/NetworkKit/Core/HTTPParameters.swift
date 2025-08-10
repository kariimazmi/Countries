//
//  HTTPParameters.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

public typealias Params = [String: Any]
public enum HTTPParameters {
    case query(_: Params)
}
