//
//  GetAllCountriesUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Combine

final class GetAllCountriesUseCase: GetCountriesUseCaseContract {
    private let repository: HomeRepositoryContract
    
    init(repository: HomeRepositoryContract = HomeRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func execute(using countryCode: String?) async throws -> [CountryPresentable] {
        let countries = try await repository.getAllCountries()
        return countries
            .filter {
                if let countryCode { return $0.code == countryCode }
                return true
            }
            .map {
                CountryPresentable(country: $0)
            }
    }
}
