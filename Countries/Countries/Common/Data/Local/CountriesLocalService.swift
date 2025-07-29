//
//  CountriesLocalService.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import CoreData

final class CountriesLocalService: CountriesLocalServiceContract {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
    }
    
    func load() async throws -> [CountryResponse] {
        let context = container.newBackgroundContext()
        
        return await context.perform {
            let fetchRequest = Country.fetchRequest()
            let countries = try? context.fetch(fetchRequest)
            
            return countries?
                .compactMap { country in
                    let currencies = (country.currencies?.allObjects as? [Currency])?
                        .compactMap { currency in
                            CurrencyResponse(
                                code: currency.code,
                                name: currency.name,
                                symbol: currency.symbol
                            )
                        }
                    
                    return CountryResponse(
                        code: country.code,
                        name: country.name,
                        capital: country.capital,
                        flag: country.flag,
                        currencies: currencies
                    )
                } ?? []
        }
    }
    
    func save(_ countries: [CountryResponse]) async throws {
        let context = container.newBackgroundContext()
        try await context.perform {
            for country in countries {
                let countryEntity = Country(context: context)
                countryEntity.name = country.name
                countryEntity.code = country.code
                countryEntity.capital = country.capital
                countryEntity.flag = country.flag

                if let currencies = country.currencies {
                    for currency in currencies {
                        let currencyEntity = Currency(context: context)
                        currencyEntity.code = currency.code
                        currencyEntity.name = currency.name
                        currencyEntity.symbol = currency.symbol
                        currencyEntity.country = countryEntity
                    }
                }
            }
            
            try context.save()
        }
    }
}

private extension CountryResponse {
    init?(
        code: String?,
        name: String?,
        capital: String?,
        flag: String?,
        currencies: [CurrencyResponse]?
    ) {
        guard let code,
            let name,
              let flag
        else {
            return nil
        }
        
        self.code = code
        self.name = name
        self.capital = capital
        self.flag = flag
        self.currencies = currencies
    }
}

private extension CurrencyResponse {
    init?(
        code: String?,
        name: String?,
        symbol: String?
    ) {
        guard let code,
            let name,
              let symbol
        else {
            return nil
        }
        
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
