//
//  HomeView.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelContract>: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel: ViewModel
    @State private var isSheetPresented: Bool = false
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            listView
                .navigationTitle("Home")
                .toolbar { openPickerViewButton }
        }
        .sheet(
            isPresented: $isSheetPresented,
            onDismiss: viewModel.onAppear
        ) {
            let viewModel = PickerViewModel()
            PickerView(viewModel: viewModel)
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

private extension HomeView {
    var listView: some View {
        List {
            ForEach(viewModel.countries, id: \.code) { country in
                NavigationLink {
                    let viewModel = DetailViewModel(country: country)
                    DetailView(viewModel: viewModel)
                } label: {
                    CountryRowView(country: country)
                }
            }
            .onDelete(perform: viewModel.onDelete)
        }
    }
    
    var openPickerViewButton: some View {
        Button {
            isSheetPresented = true
        } label: {
            Image(systemName: "plus.circle.fill")
        }
    }
}
