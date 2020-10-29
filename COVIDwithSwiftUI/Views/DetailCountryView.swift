//
//  DetailCountryView.swift
//  COVIDwithSwiftUI
//
//  Created by Ramill Ibragimov on 28.10.2020.
//

import Foundation
import SwiftUI

struct DetailCountryView: View {
    
    @ObservedObject var apiService = APIService<[LiveStats]>()
    let country: Country
    
    var body: some View {
        VStack {
            switch apiService.state {
            case .isLoading:
                Text("Loading...")
            case .hasData(let stats):
                Form {
                    Section {
                        Text("Cases: \(stats.last?.Cases ?? -1)")
                    }
                }
            }
        }.onAppear {
            apiService.getStats(slug: country.slug)
        }
    }
}
