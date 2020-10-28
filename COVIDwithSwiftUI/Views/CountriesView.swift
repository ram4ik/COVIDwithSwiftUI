//
//  ContentView.swift
//  COVIDwithSwiftUI
//
//  Created by Ramill Ibragimov on 28.10.2020.
//

import SwiftUI

struct CountriesView: View {
    @ObservedObject var apiService = APIService<[Country]>()
    
    var body: some View {
        NavigationView {
            VStack {
                switch apiService.state {
                    case .isLoading:
                        Text("Loading...")
                    case .hasData(let countries):
                        List(countries.sorted { $0.name < $1.name }, id: \.code ) { country in
                            NavigationLink(
                                destination: DetailCountryView(country: country),
                                label: {
                                    Text(country.name)
                                }
                            )
                        }
                }
            }
        }.onAppear {
            apiService.getCountries()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}