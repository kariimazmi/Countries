//
//  UpdateCountryUseCaseContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

protocol UpdateCountryUseCaseContract {
    func execute(_ country: CountryPresentable) async throws
}
