//
//  GetAllCountriesUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Combine

final class GetAllCountriesUseCase: GetAllCountriesUseCaseContract {
    private let repository: HomeRepositoryContract
    
    init(repository: HomeRepositoryContract = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [CountryPresentable] {
        let countries = try await repository.getAllCountries()
        return countries.map {  CountryPresentable(country: $0) }
    }
}
