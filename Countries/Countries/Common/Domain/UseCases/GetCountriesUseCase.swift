//
//  GetAllCountriesUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Combine

final class GetAllCountriesUseCase: GetCountriesUseCaseContract {
    private let repository: CountriesRepositoryContract
    
    init(repository: CountriesRepositoryContract = CountriesRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func execute() async throws -> [CountryPresentable] {
        let countries = try await repository.getAllCountries()
        return countries.map { CountryPresentable(country: $0) }
    }
}
