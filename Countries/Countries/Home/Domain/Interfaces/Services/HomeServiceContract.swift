//
//  CountryServiceContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol HomeServiceContract {
    func getAllCountries() async throws -> [Country]
}
