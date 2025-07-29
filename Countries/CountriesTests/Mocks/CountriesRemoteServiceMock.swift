//
//  CountriesRemoteServiceMock.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

@testable import Countries

final class CountriesRemoteServiceMock: CountriesRemoteServiceContract {
    var getAllCountriesWasCalled = false
    var getAllCountriesReturnValue: [CountryResponse] = []
    var getAllCountriesThrowableError: Error?
    
    func getAllCountries() async throws -> [CountryResponse] {
        if let error = getAllCountriesThrowableError {
            throw error
        }
        getAllCountriesWasCalled = true
        return getAllCountriesReturnValue
    }
}
