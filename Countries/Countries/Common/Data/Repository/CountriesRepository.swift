//
//  CountriesRepository.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

final class CountriesRepository: CountriesRepositoryContract {
    private let remote: CountriesRemoteServiceContract
    private let local: CountriesLocalServiceContract
    
    init(
        remote: CountriesRemoteServiceContract = CountriesRemoteService(),
        local: CountriesLocalServiceContract = CountriesLocalService()
    ) {
        self.remote = remote
        self.local = local
    }
    
    func getAllCountries() async throws -> [CountryResponse] {
        if let cachedCountries = try? await local.load(),
            !cachedCountries.isEmpty {
            return cachedCountries
        }
        
        let remoteCountries = try await remote.getAllCountries()
        try await local.save(remoteCountries)
        
        return remoteCountries
    }
    
    func updateCountry(_ country: CountryResponse) async throws {
        try await local.update(country)
    }
}
