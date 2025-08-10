//
//  CountriesRemoteServiceContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol CountriesRemoteServiceContract {
    func getAllCountries() async throws -> [CountryResponse]
}
