//
//  MockBundle.swift
//  NetworkKit
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

final class MockBundle: Bundle {
    override var infoDictionary: [String: Any]? {
        ["hostname": "https://api.example.com"]
    }
}
