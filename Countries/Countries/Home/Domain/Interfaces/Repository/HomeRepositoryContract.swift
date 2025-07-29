//
//  HomeRepositoryContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol HomeRepositoryContract {
    func getAllCountries() async throws -> [Country]
}
