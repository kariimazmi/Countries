//
//  CountriesRepository.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

final class CountriesRepository: CountriesRepositoryContract {
    private let service: CountriesServiceContract
    
    init(service: CountriesServiceContract = CountriesService()) {
        self.service = service
    }
    
    func getAllCountries() async throws -> [Country] {
        try await service.getAllCountries()
    }
}
