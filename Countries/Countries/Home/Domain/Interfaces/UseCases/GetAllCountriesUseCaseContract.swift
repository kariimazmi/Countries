//
//  GetAllCountriesUseCaseUseCaseContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol GetAllCountriesUseCaseContract {
    func execute() async throws -> [CountryPresentable] 
}
