//
//  UpdateCountryUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

final class UpdateCountryUseCase: UpdateCountryUseCaseContract {
    private let repository: CountriesRepositoryContract
    
    init(repository: CountriesRepositoryContract = CountriesRepository()) {
        self.repository = repository
    }
    
    func execute(_ country: CountryPresentable) async throws {
        var country = country
        country.isFavourite.toggle()
        
        try await repository.updateCountry(country.toResponse)
    }
}
