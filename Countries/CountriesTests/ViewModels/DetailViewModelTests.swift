//
//  DetailViewModelTests.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import XCTest
@testable import Countries

final class DetailViewModelTests: XCTestCase {
    private var sut: DetailViewModel!
    private var country: CountryPresentable!
    
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
        sut = DetailViewModel(country: country)
    }
    
    override func tearDown() {
        sut = nil
        country = nil
        super.tearDown()
    }
    
    func testSUT_whenInitCalled_shouldSetCountryName() {
        // Then
        XCTAssertEqual(sut.countryName, country.name)
    }
    
    func testSUT_whenInitCalled_shouldSetCountryCode() {
        // Then
        XCTAssertEqual(sut.countryCode, "(\(country.code))")
    }
    
    func testSUT_whenInitCalled_shouldSetCountryCapital() {
        // Then
        XCTAssertEqual(sut.countryCapital, "Capital: \(country.capital)")
    }
    
    func testSUT_whenInitCalled_shouldSetCountryCurrencies() {
        // Then
        XCTAssertEqual(sut.countryCurrencies, "Currencies: \(country.currencyDescription)")
    }
    
    func testSUT_whenInitCalled_shouldSetCountryFlag() {
        // Then
        XCTAssertNotNil(sut.imageUrl)
    }
} 
