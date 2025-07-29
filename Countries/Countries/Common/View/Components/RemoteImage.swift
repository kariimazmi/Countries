//
//  RemoteImage.swift
//  Countries
//
//  Created by Karim Azmi on 29/7/25.
//

import SwiftUI

struct RemoteImage: View {
    private let url: URL
    
    init (url: URL) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url){ result in
            result.image?
                .resizable()
                .scaledToFit()
        }
    }
}
