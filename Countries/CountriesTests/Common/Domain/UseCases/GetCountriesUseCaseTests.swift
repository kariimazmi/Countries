//
//  GetAllCountriesUseCase.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries

final class GetAllCountriesUseCaseTests: XCTestCase {
    private var sut: GetAllCountriesUseCase!
    private var mock: MockCountriesRepository!
    
    override func setUp() {
        super.setUp()
        mock = .init()
        sut = .init(repository: mock)
    }
    
    override func tearDown() {
        sut = nil
        mock = nil
        super.tearDown()
    }
    
    func testSUT_whenExecuteCalled_shouldReturnTwoCountries() async {
        // When
        let result = try? await sut.execute()
        
        // Then
        XCTAssertEqual(result?.count, 2)
    }
    
    func testSUT_whenExecuteCalled_shouldReturnSortedCountries() async {
        // Given
        let expectedCountryCodes: [String] = ["EG", "US"]
        
        // When
        let result = try? await sut.execute().map(\.code)
        
        // Then
        XCTAssertEqual(result, expectedCountryCodes)
    }
    
    func testSUT_whenExecuteCalled_shouldReturnError() async {
        // Given
        mock.shouldThrow = true
        
        // When & Then
        do {
            _ = try await sut.execute()
            XCTFail("Expected to throw, but succeeded")
        } catch {
            XCTAssertTrue(error is MockCountriesRepository.TestError)
        }
    }
}
