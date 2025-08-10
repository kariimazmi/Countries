//
//  UpdateCountryUseCaseTests.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries

final class UpdateCountryUseCaseTests: XCTestCase {
    private var country: CountryPresentable!
    private var sut: UpdateCountryUseCase!
    private var mock: MockCountriesRepository!
    
    override func setUp() {
        super.setUp()
        let jsonData = """
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
        """.data(using: .utf8)!
        let response = try! JSONDecoder().decode(CountryResponse.self, from: jsonData)
        country = CountryPresentable(country: response)
        mock = .init()
        sut = .init(repository: mock)
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        country = nil
        super.tearDown()
    }
    
    func testSUT_whenExecuteCalled_shouldUpdateCountry() async {
        // When
        try? await sut.execute(country)
        
        // Then
        XCTAssertNotNil(mock.updatedCountry)
    }
    
    func testSUT_whenExecuteCalled_shouldReturnError() async {
        // Given
        mock.shouldThrow = true
        
        // When & Then
        do {
            _ = try await sut.execute(country)
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is MockCountriesRepository.TestError)
        }
    }
}
