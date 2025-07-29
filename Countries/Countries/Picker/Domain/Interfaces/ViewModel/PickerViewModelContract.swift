//
//  PickerViewModelContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

typealias PickerViewModelContract = PickerViewModelInput & PickerViewModelOutput

protocol PickerViewModelInput: ObservableObject {
    var searchText: String { get set }
    
    func onAppear()
    func onTap(country: CountryPresentable)
}

protocol PickerViewModelOutput: ObservableObject {
    var filteredCountries: [CountryPresentable] { get }
    var shouldDismissScreen: Bool { get }
}
