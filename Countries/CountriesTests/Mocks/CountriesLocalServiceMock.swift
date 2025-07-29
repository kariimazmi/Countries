//
//  CountriesLocalServiceMock.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

@testable import Countries

final class CountriesLocalServiceMock: CountriesLocalServiceContract {
    var loadWasCalled = false
    var loadReturnValue: [CountryResponse] = []
    var loadThrowableError: Error?
    
    var saveWasCalled = false
    var saveThrowableError: Error?
    
    var updateWasCalled = false
    var updateThrowableError: Error?
    
    func load() async throws -> [CountryResponse] {
        if let error = loadThrowableError {
            throw error
        }
        loadWasCalled = true
        return loadReturnValue
    }
    
    func save(_ countries: [CountryResponse]) async throws {
        if let error = saveThrowableError {
            throw error
        }
        saveWasCalled = true
    }
    
    func update(_ country: CountryResponse) async throws {
        if let error = updateThrowableError {
            throw error
        }
        updateWasCalled = true
    }
} 
