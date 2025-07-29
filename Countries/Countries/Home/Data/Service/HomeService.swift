//
//  HomeService.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import NetworkKit

final class HomeService: HomeServiceContract {
    private let service: APIServiceContract
    
    init(service: APIServiceContract = APIService.shared) {
        self.service = service
    }
    
    func getAllCountries() async throws -> [Country] {
        let parameters = AllCountriesRequest(
            fields: [
                "alpha2Code",
                "name",
                "capital",
                "flags",
                "currencies"
            ]
        )
        
        let request = APIBuilder()
            .setMethod(using: .get)
            .setPath(using: "all")
            .setParameters(using: .query(parameters.dictionary))
            .build()
        
        return try await service.request(using: request, responseType: [Country].self)
    }
}
