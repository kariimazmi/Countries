//
//  PickerViewModel.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import Combine

final class PickerViewModel: PickerViewModelContract {
    private let getCountriesUseCase: GetCountriesUseCaseContract
    private let updateCountryUseCase: UpdateCountryUseCaseContract
    private var subscriptions: Set<AnyCancellable> = []
    private var allCountries: [CountryPresentable] = []
    private let maxFavouriteCountries: Int = 5
    
    @Published var searchText: String = ""
    @Published var filteredCountries: [CountryPresentable] = []
    @Published var shouldDismissScreen: Bool = false
    
    init(
        getCountriesUseCase: GetCountriesUseCaseContract = GetAllCountriesUseCase(),
        updateCountryUseCase: UpdateCountryUseCaseContract = UpdateCountryUseCase()
    ) {
        self.getCountriesUseCase = getCountriesUseCase
        self.updateCountryUseCase = updateCountryUseCase
        
        subscribeToSearchTextChanges()
    }
}

extension PickerViewModel {
    func onAppear() {
        Task { @MainActor in
            do {
                allCountries = try await getCountriesUseCase.execute()
                filteredCountries = allCountries
            } catch {
                debugPrint("ERROR: \(error)")
            }
        }
    }
    
    func onTap(country: CountryPresentable) {
        Task { @MainActor in
            do {
                if await validateIfLimitNotExeeded(!country.isFavourite) {
                    try await updateCountryUseCase.execute(country)
                    shouldDismissScreen = true
                }
            } catch {
                debugPrint("ERROR: \(error)")
            }
        }
    }
}

private extension PickerViewModel {
    func subscribeToSearchTextChanges() {
        $searchText
            .sink { [weak self] text in
                guard let self else { return }
                
                if text.isEmpty {
                    self.filteredCountries = self.allCountries
                } else {
                    self.filteredCountries = self.allCountries
                        .filter {
                            $0.name.lowercased().contains(text.lowercased())
                        }
                }
            }
            .store(in: &subscriptions)
    }
    
    func validateIfLimitNotExeeded(_ isFavourite: Bool) async -> Bool {
        let favouriteCountries = (try? await getCountriesUseCase
            .execute()
            .filter { $0.isFavourite }
            .count) ?? .zero
        
        let value = isFavourite ? 1 : -1
        return (favouriteCountries + value) <= maxFavouriteCountries
    }
}
