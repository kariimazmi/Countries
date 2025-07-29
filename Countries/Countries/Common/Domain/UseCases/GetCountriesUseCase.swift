//
//  GetAllCountriesUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

final class GetAllCountriesUseCase: GetCountriesUseCaseContract {
    private let repository: CountriesRepositoryContract
    
    init(repository: CountriesRepositoryContract = CountriesRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func execute() async throws -> [CountryPresentable] {
        let countries = try await repository.getAllCountries()
        return countries
            .sorted(by: { $0.name < $1.name })
            .map { CountryPresentable(country: $0) }
    }
}
