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
    
    var isFavourite: Bool
    private(set) var _currencies: [CurrencyResponse]?

    init(country: CountryResponse) {
        name = country.name
        code = country.code
        capital = country.capital ?? "N/A"
        flag = URL(string: country.flag)
        _currencies = country.currencies
        if let currencies = country.currencies,
            !currencies.isEmpty {
            currencyDescription = currencies.map {
                "\($0.name) (\($0.symbol))"
            }.joined(separator: ", ")
        } else {
            currencyDescription = "No currency info"
        }
        
        isFavourite = country.isFavourite
    }
}

extension CountryPresentable {
    var toResponse: CountryResponse {
        .init(model: self)
    }
}

private extension CountryResponse {
    init(model: CountryPresentable) {
        self.code = model.code
        self.name = model.name
        self.capital = model.capital
        self.flag = model.flag?.absoluteString ?? ""
        self.currencies = model._currencies
        self.isFavourite = model.isFavourite
    }
}
