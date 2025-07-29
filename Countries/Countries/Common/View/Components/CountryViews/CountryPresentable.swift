//
//  CountryPresentable.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

struct CountryPresentable {
    let name: String
    let code: String
    let capital: String
    let flag: URL?
    let currencyDescription: String

    init(country: Country) {
        name = country.name
        code = country.code
        capital = country.capital ?? "N/A"
        flag = URL(string: country.flag)

        if let currencies = country.currencies,
            !currencies.isEmpty {
            currencyDescription = currencies.map {
                "\($0.name) (\($0.symbol))"
            }.joined(separator: ", ")
        } else {
            currencyDescription = "No currency info"
        }
    }
}
