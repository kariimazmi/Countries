//
//  File.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

private extension Encodable {
    var data: Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            fatalError("Couldn't encode Data")
        }
    }
}

public extension Encodable {
    var dictionary: [String: Any] {
        (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
