//
//  HomeViewModel.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Foundation

final class HomeViewModel: HomeViewModelContract {
    private let getCurrentCountryUseCase: GetCurrentCountryUseCaseContract
    private let updateCountryUseCase: UpdateCountryUseCaseContract
    
    private let getCountriesUseCase: GetCountriesUseCaseContract
    
    @Published var countries: [CountryPresentable] = []
    
    init(getCurrentCountryUseCase: GetCurrentCountryUseCaseContract = GetCurrentCountryUseCase(),
         getCountriesUseCase: GetCountriesUseCaseContract = GetAllCountriesUseCase(),
         updateCountryUseCase: UpdateCountryUseCaseContract = UpdateCountryUseCase()
    ) {
        self.getCurrentCountryUseCase = getCurrentCountryUseCase
        self.getCountriesUseCase = getCountriesUseCase
        self.updateCountryUseCase = updateCountryUseCase
    }
}

extension HomeViewModel {
    func onAppear() {
        Task { @MainActor in
            do {
                let countryCode = try await getCurrentCountryUseCase.execute()
                let allCountries = try await getCountriesUseCase.execute()
                
                countries = allCountries
                    .filter {
                        $0.code == countryCode || $0.isFavourite
                    }
            } catch {
                debugPrint("ERROR: \(error)")
            }
        }
    }
    
    func onDelete(at offsets: IndexSet) {
        guard let country = offsets.compactMap({ countries[$0] }).first else { return }
        Task { @MainActor in
            try? await updateCountryUseCase.execute(country)
            countries.remove(atOffsets: offsets)
        }
    }
}

