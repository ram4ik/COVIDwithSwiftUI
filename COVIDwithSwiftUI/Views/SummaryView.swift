//
//  ContentView.swift
//  COVIDwithSwiftUI
//
//  Created by Ramill Ibragimov on 28.10.2020.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var apiService = APIService<Summary>()
    
    var body: some View {
        NavigationView {
            VStack {
                switch apiService.state {
                    case .isLoading:
                        Text("Loading...")
                    case .hasData(let summary):
                        List(summary.Countries.sorted { $0.name < $1.name }, id: \.slug ) { country in
                            NavigationLink(
                                destination: DetailCountryView(country: country),
                                label: {
                                    HStack {
                                        Text(country.name)
                                        Spacer()
                                        Text("\(country.totalRecovered)/\(country.totalConfirmed)")
                                            .foregroundColor(.secondary)
                                            .font(Font.system(.body).monospacedDigit())
                                            .multilineTextAlignment(.trailing)
                                    }
                                }
                            )
                        }
                }
            }.navigationBarTitle("COVID19 stats")
        }.onAppear {
            apiService.getSummary()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
