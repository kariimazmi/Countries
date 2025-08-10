//
//  GetCurrentCountryUseCaseContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//


protocol GetCurrentCountryUseCaseContract {
    func execute() async throws -> String
}
