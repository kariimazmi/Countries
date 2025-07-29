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
        let cachedCountries = try? await local.load()
        if let cachedCountries {
            return cachedCountries
        }
        
        let remoteCountries = try await remote.getAllCountries()
        try await local.save(remoteCountries)
        
        return remoteCountries
    }
}
