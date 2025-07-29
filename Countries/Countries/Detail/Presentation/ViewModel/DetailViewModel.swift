//
//  DetailViewModel.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

final class DetailViewModel: DetailViewModelContract {
    private let country: CountryPresentable
    
    init(country: CountryPresentable) {
        self.country = country
    }
}

extension DetailViewModel {
    var imageUrl: URL? { country.flag }
    var countryName: String { country.name }
    var countryCode: String { "(\(country.code))" }
    var countryCapital: String { "Capital: \(country.capital)" }
    var countryCurrencies: String { "Currencies: \(country.currencyDescription)" }
}
