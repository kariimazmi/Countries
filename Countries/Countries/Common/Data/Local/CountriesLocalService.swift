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
            
            return countries?.compactMap { CountryResponse(entity: $0) } ?? []
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
                countryEntity.isFavourite = country.isFavourite

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
    
    func update(_ country: CountryResponse) async throws {
        let context = container.newBackgroundContext()
        
        try await context.perform {
            let fetchRequest = Country.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "code == %@", country.code)
            
            let entity = try? context.fetch(fetchRequest).first
            entity?.code = country.code
            entity?.name = country.name
            entity?.capital = country.capital
            entity?.flag = country.flag
            entity?.isFavourite = country.isFavourite
            
            try context.save()
        }
    }
}

private extension CountryResponse {
    init?(entity: Country) {
        guard let code = entity.code,
              let name = entity.name,
              let capital = entity.capital,
              let flag = entity.flag
        else {
            return nil
        }
        
        self.code = code
        self.name = name
        self.capital = capital
        self.flag = flag
        self.currencies = (entity.currencies?.allObjects as? [Currency])?
            .compactMap(CurrencyResponse.init)
        self.isFavourite = entity.isFavourite
    }
}

private extension CurrencyResponse {
    init?(entity: Currency) {
        guard let code = entity.code,
              let name = entity.name,
              let symbol = entity.symbol
        else {
            return nil
        }
        
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
