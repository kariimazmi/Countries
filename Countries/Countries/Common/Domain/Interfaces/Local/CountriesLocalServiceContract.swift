//
//  CountriesLocalServiceContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol CountriesLocalServiceContract {
    func load() async throws -> [CountryResponse]
    func save(_ countries: [CountryResponse]) async throws
}
