//
//  MockCountriesRepository.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

@testable import Countries
import Foundation

final class MockCountriesRepository: CountriesRepositoryContract {
    enum TestError: Error { case failure }
    
    var updatedCountry: CountryResponse?
    var shouldThrow = false

    func getAllCountries() async throws -> [CountryResponse] {
        if shouldThrow { throw TestError.failure }
        
        let jsonData = """
        [
            {
                "name": "United States of America",
                "alpha2Code": "US",
                "capital": "Washington, D.C.",
                "flags": {
                    "svg": "https://flagcdn.com/us.svg",
                    "png": "https://flagcdn.com/w320/us.png"
                },
                "currencies": [
                    {
                        "code": "USD",
                        "name": "United States dollar",
                        "symbol": "$"
                    }
                ],
                "independent": false
            },
            {
                "name": "Egypt",
                "alpha2Code": "EG",
                "capital": "Cairo",
                "flags": {
                    "svg": "https://flagcdn.com/eg.svg",
                    "png": "https://flagcdn.com/w320/eg.png"
                },
                "currencies": [
                    {
                        "code": "EGP",
                        "name": "Egyptian pound",
                        "symbol": "Â£"
                    }
                ]
            }
        ]
        """.data(using: .utf8)!
        return try! JSONDecoder().decode([CountryResponse].self, from: jsonData)
    }
    
    func updateCountry(_ country: CountryResponse) async throws {
        if shouldThrow { throw TestError.failure }
        updatedCountry = country
    }
}
