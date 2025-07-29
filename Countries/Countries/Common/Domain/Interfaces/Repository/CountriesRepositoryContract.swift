//
//  CountriesRepositoryContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol CountriesRepositoryContract {
    func getAllCountries() async throws -> [Country]
}
