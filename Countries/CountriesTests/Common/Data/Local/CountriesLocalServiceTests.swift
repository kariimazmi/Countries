//
//  CountriesLocalServiceTests.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries

final class CountriesLocalServiceTests: XCTestCase {
    private var sampleCountry: CountryResponse!
    private var persistenceController: PersistenceController!
    private var sut: CountriesLocalService!

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
        sampleCountry = ((try? JSONDecoder().decode([CountryResponse].self, from: jsonData)) ?? []).first!
        
        persistenceController = PersistenceController(inMemory: true)
        sut = CountriesLocalService(container: persistenceController.container)
    }

    override func tearDown() {
        sut = nil
        persistenceController = nil
        sampleCountry = nil
        
        super.tearDown()
    }

    func testSUT_whenSaveCalled_shouldSaveOneCountryToCoreData() async throws {
        // When
        try await sut.save([sampleCountry])
        let result = try await sut.load()

        // Then
        XCTAssertEqual(result.count, 1)
    }
    
    func testSUT_whenSaveCalled_shouldSaveEgyptToCoreData() async throws {
        // When
        try await sut.save([sampleCountry])
        let result = try await sut.load()

        // Then
        XCTAssertEqual(result.first?.name, "Egypt")
    }

    func testSUT_whenLoadCalled_withoutSave_shouldReturnEmptyArray() async throws {
        // When
        let result = try await sut.load()

        // Then
        XCTAssertEqual(result.count, 0)
    }
    
    func testSUT_whenUpdateCalled_shouldModifyExistingCountry() async throws {
        // Given
        try await sut.save([sampleCountry])

        let jsonData = """
        {
            "name": "New Egypt",
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
        let updated  = try! JSONDecoder().decode(CountryResponse.self, from: jsonData)
        
        // When
        try await sut.update(updated)
        let result = try await sut.load()

        // Then
        XCTAssertEqual(result.first?.name, "New Egypt")
    }
}
