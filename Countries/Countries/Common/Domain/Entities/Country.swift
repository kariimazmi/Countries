//
//  Country.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

typealias Countries = [Country]
struct Country: Decodable {
    let code: String
    let name: String
    let capital: String?
    let flag: String
    let currencies: [Currency]?

    enum CodingKeys: String, CodingKey {
        case name
        case code = "alpha2Code"
        case capital
        case flags
        case currencies
    }

    enum FlagsKeys: String, CodingKey {
        case png
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        capital = try container.decodeIfPresent(String.self, forKey: .capital)
        currencies = try container.decodeIfPresent([Currency].self, forKey: .currencies)

        let flagsContainer = try container.nestedContainer(keyedBy: FlagsKeys.self, forKey: .flags)
        flag = try flagsContainer.decode(String.self, forKey: .png)
    }
}

struct Currency: Codable {
    let code: String
    let name: String
    let symbol: String
}
