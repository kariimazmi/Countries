//
//  HomeViewModel.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

final class HomeViewModel: HomeViewModelContract {
    private let getCurrentCountryUseCase: GetCurrentCountryUseCaseContract
    
    private let getCountriesUseCase: GetCountriesUseCaseContract
    
    @Published var countries: [CountryPresentable] = []
    
    init(getCurrentCountryUseCase: GetCurrentCountryUseCaseContract = GetCurrentCountryUseCase(),
         getCountriesUseCase: GetCountriesUseCaseContract = GetAllCountriesUseCase()
    ) {
        self.getCurrentCountryUseCase = getCurrentCountryUseCase
        self.getCountriesUseCase = getCountriesUseCase
    }
}

extension HomeViewModel {
    func onAppear() {
        Task { @MainActor in
            do {
//                let country = try await getCurrentCountryUseCase.execute()
//                debugPrint(country)
                countries = try await getCountriesUseCase.execute()
            } catch {
                debugPrint("ERROR: \(error)")
            }
        }
    }
    
    func onDelete(at offsets: IndexSet) {
//        debugPrint("Before: \(countries.count)")
//        countries.remove(atOffsets: offsets)
//        debugPrint("After: \(countries.count)")
    }
}

