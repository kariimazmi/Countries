//
//  CountriesRemoteServiceTests.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries

final class CountriesRemoteServiceTests: XCTestCase {
    private var expectedCountries: [CountryResponse]!
    private var sut: CountriesRemoteService!
    private var mock: MockAPIService!
    
    override func setUp() {
        super.setUp()
        let jsonData = """
        [
            {
                "name": "Egypt",
                "alpha2Code": "EG",
                "capital": "Cairo",
                "flags": {
                    "svg": "https://flagcdn.com/eg.svg",
                    "png": "https://flagcdn.com/w320/eg.png"
                },
                "currencies": [
                    {
                        "code": "EGP",
                        "name": "Egyptian pound",
                        "symbol": "Â£"
                    }
                ]
            }
        ]
        """.data(using: .utf8)!
        expectedCountries = (try? JSONDecoder().decode([CountryResponse].self, from: jsonData)) ?? []
        mock = .init()
        sut = CountriesRemoteService(service: mock)
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        expectedCountries = nil
        
        super.tearDown()
    }
    
    func testSUT_whenGetAllCountriesCalled_whenRequestSucceeds_shouldReturnCountryName() async throws {
        // Given
        mock.mockResponse = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        
        // Then
        XCTAssertEqual(result.first?.name, "Egypt")
    }
    
    func testSUT_whenGetAllCountriesCalled_whenRequestSucceeds_shouldReturnCountryCode() async throws {
        // Given
        mock.mockResponse = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        
        // Then
        XCTAssertEqual(result.first?.code, "EG")
    }
    
    func testSUT_whenGetAllCountriesCalled_whenRequestSucceeds_shouldReturnCountryCapital() async throws {
        // Given
        mock.mockResponse = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.first?.capital, "Cairo")
    }
    
    func testSUT_whenGetAllCountriesCalled_whenRequestSucceeds_shouldReturnCountryFlag() async throws {
        // Given
        mock.mockResponse = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.first?.flag, "https://flagcdn.com/w320/eg.png")
    }
    
    func testSUT_whenGetAllCountriesCalled_whenRequestSucceeds_shouldReturnOneCountryCurrency() async throws {
        // Given
        mock.mockResponse = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.first?.currencies?.count, 1)
    }
    
    func testSUT_whenGetAllCountriesCalled_whenRequestSucceeds_shouldReturnNoneFavouriteCountry() async throws {
        // Given
        mock.mockResponse = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertFalse(result.first?.isFavourite ?? false)
    }
}
