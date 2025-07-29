//
//  CountryRowView.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI

public struct CountryRowView: View {
    private let country: CountryPresentable
    
    public init(country: CountryPresentable) {
        self.country = country
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            iconView
            titleView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 16.0)
    }
}

private extension CountryRowView {
    @ViewBuilder
    var iconView: some View {
        if let url = country.flag {
            RemoteImage(url: url)
                .frame(width: 32.0, height: 32.0)
        }
    }
    
    var titleView: some View {
        Text(country.name)
            .font(.title)
            .foregroundColor(.white)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
}
