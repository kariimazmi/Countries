//
//  DetailView.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI

struct DetailView<ViewModel: DetailViewModelContract>: View {
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        contentView
    }
}

private extension DetailView {
    var contentView: some View {
        VStack(spacing: 8.0) {
            imageView
            
            VStack(spacing: 4.0) {
                VStack(spacing: 2.0) {
                    countryNameView
                    countryCodeView
                }
                
                countryCapitalView
                countryCurrenciesView
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(16.0)
        .background(Color.gray)
        .cornerRadius(14.0)
        .padding(16.0)
    }
    
    @ViewBuilder
    var imageView: some View {
        if let url = viewModel.imageUrl {
            RemoteImage(url: url)
                .frame(width: 200, height: 200)
        }
    }
    
    var countryNameView: some View {
        Text(viewModel.countryName)
            .font(.largeTitle)
    }
    
    var countryCodeView: some View {
        Text(viewModel.countryCode)
            .font(.caption)
    }
    
    var countryCapitalView: some View {
        Text(viewModel.countryCapital)
            .font(.title3)
    }
    
    var countryCurrenciesView: some View {
        Text(viewModel.countryCurrencies)
            .font(.body)
    }
}
