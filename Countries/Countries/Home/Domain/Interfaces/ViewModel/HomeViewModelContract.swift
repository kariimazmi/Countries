//
//  HomeViewModelContract.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

typealias HomeViewModelContract = ObservableObject & HomeViewModelInput & HomeViewModelOutput

protocol HomeViewModelOutput {
    var countries: [CountryPresentable] { get }
}

protocol HomeViewModelInput {
    func onAppear()
    func onDelete(at offsets: IndexSet)
}
