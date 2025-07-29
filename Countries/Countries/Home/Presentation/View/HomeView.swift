//
//  HomeView.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI
import DesignKit

struct HomeView<ViewModel: HomeViewModelContract>: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Home")
        }
        .onAppear(perform: viewModel.onAppear)
    }
}
