//
//  CountriesServiceContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol CountriesServiceContract {
    func getAllCountries() async throws -> [Country]
}
