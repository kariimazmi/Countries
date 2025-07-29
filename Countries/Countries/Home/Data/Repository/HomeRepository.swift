//
//  HomeRepository.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Combine

final class HomeRepository: HomeRepositoryContract {
    private let service: HomeServiceContract
    
    init(service: HomeServiceContract = HomeService()) {
        self.service = service
    }
    
    func getAllCountries() async throws -> [Country] {
        try await service.getAllCountries()
    }
}
