//
//  DetailViewModelContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

typealias DetailViewModelContract = DetailViewModelOutput

protocol DetailViewModelOutput {
    var imageUrl: URL? { get }
    var countryName: String { get }
    var countryCode: String { get }
    var countryCapital: String { get }
    var countryCurrencies: String { get }
}
