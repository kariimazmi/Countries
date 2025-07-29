//
//  PickerView.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI

struct PickerView<ViewModel: PickerViewModelContract>: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            textField
            listView
        }
        .onChange(of: viewModel.shouldDismissScreen) { newValue in
            if newValue {
                dismiss.callAsFunction()
            }
        }
    }
}

private extension PickerView {
    var textField: some View {
        TextField("Search...", text: $viewModel.searchText)
            .autocorrectionDisabled()
            .padding(.vertical, 16.0)
            .padding(.horizontal, 8.0)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    var listView: some View {
        List {
            ForEach(viewModel.filteredCountries, id: \.code) { country in
                HStack {
                    CountryRowView(country: country)
                    addTrailingAction(for: country)
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
    
    @ViewBuilder
    func addTrailingAction(for country: CountryPresentable) -> some View {
        let isFavourite = country.isFavourite
        let role: ButtonRole = isFavourite ? .destructive : .cancel
        let image = isFavourite ? "minus.circle.fill" : "plus.circle.fill"
        
        Button(
            role: role,
            action: {
                viewModel.onTap(country: country)
            },
            label: {
                Image(systemName: image)
                    .font(.title3)
                    .padding()
            }
        )
    }
}
