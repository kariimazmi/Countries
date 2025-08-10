//
//  GetCountriesUseCaseContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol GetCountriesUseCaseContract {
    func execute() async throws -> [CountryPresentable]
}
