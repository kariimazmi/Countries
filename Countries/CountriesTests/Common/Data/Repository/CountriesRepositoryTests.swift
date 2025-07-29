//
//  CountriesRepositoryTests.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries

final class CountriesRepositoryTests: XCTestCase {
    private var expectedCountries: [CountryResponse]!
    private var sut: CountriesRepository!
    private var remoteMock: CountriesRemoteServiceMock!
    private var localMock: CountriesLocalServiceMock!
    
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
        remoteMock = CountriesRemoteServiceMock()
        localMock = CountriesLocalServiceMock()
        sut = CountriesRepository(remote: remoteMock, local: localMock)
    }
    
    override func tearDown() {
        sut = nil
        remoteMock = nil
        localMock = nil
        expectedCountries = nil
        super.tearDown()
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheExists_shouldReturnOneCachedObject() async throws {
        // Given
        localMock.loadReturnValue = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.count, 1)
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheExists_shouldReturnCachedCountryCode() async throws {
        // Given
        localMock.loadReturnValue = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.first?.code, "EG")
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheExists_shouldNotCallRemote() async throws {
        // Given
        localMock.loadReturnValue = expectedCountries
        
        // When
        let _ = try await sut.getAllCountries()
        
        // Then
        XCTAssertFalse(remoteMock.getAllCountriesWasCalled)
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheIsEmpty_shouldReturnOneRemoteObject() async throws {
        // Given
        localMock.loadReturnValue = []
        remoteMock.getAllCountriesReturnValue = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.count, 1)
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheIsEmpty_shouldReturnCachedCountryCode() async throws {
        // Given
        localMock.loadReturnValue = []
        remoteMock.getAllCountriesReturnValue = expectedCountries
        
        // When
        let result = try await sut.getAllCountries()
        
        // Then
        XCTAssertEqual(result.first?.code, "EG")
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheIsEmpty_shouldCallSaveLocal() async throws {
        // Given
        localMock.loadReturnValue = []
        remoteMock.getAllCountriesReturnValue = expectedCountries
        
        // When
        let _ = try await sut.getAllCountries()
        
        // Then
        XCTAssertTrue(localMock.saveWasCalled)
    }
    
    func testSUT_whenGetAllCountriesCalled_whenCacheIsEmpty_shouldCallRemote() async throws {
        // Given
        localMock.loadReturnValue = []
        remoteMock.getAllCountriesReturnValue = expectedCountries
        
        // When
        let _ = try await sut.getAllCountries()
        
        // Then
        XCTAssertTrue(remoteMock.getAllCountriesWasCalled)
    }
    
    func testSUT_whenUpdateCountryCalled_whenSuccess_shouldUpdateLocalStorage() async throws {
        // Given
        let country = expectedCountries.first!
        
        // When
        try await sut.updateCountry(country)
        
        // Then
        XCTAssertTrue(localMock.updateWasCalled)
    }
}
