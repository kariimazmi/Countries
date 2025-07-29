//
//  HomeViewModel.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

final class HomeViewModel: HomeViewModelContract {
    private let allCountriesUseCase: GetAllCountriesUseCaseContract
    
    @Published var countries: [CountryPresentable] = []
    
    init(allCountriesUseCase: GetAllCountriesUseCaseContract = GetAllCountriesUseCase()) {
        self.allCountriesUseCase = allCountriesUseCase
    }
}

extension HomeViewModel {
    func onAppear() {
        Task { @MainActor in
            do {
                countries = try await allCountriesUseCase.execute()
            } catch {
                debugPrint("ERROR: \(error)")
            }
        }
    }
    
    func onDelete(at offsets: IndexSet) {
        debugPrint("Before: \(countries.count)")
        countries.remove(atOffsets: offsets)
        debugPrint("After: \(countries.count)")
    }
}
