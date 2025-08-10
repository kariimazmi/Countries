//
//  CountriesApp.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI

@main
struct CountriesApp: App {
    private let homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: homeViewModel)
        }
    }
}
