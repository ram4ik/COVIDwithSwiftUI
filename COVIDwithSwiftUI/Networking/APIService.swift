//
//  APIService.swift
//  COVIDwithSwiftUI
//
//  Created by Ramill Ibragimov on 28.10.2020.
//

import Foundation
import Combine

class APIService<T: Decodable>: ObservableObject {
    
    @Published var state: State = .isLoading
    private var apiSubscriber: AnyCancellable?
    
    enum State {
        case isLoading
        case hasData(model: T)
    }
    
    func getSummary() {
        let url = URL(string: "https://api.covid19api.com/summary")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        apiSubscriber = perform(request: request)
            .sink(receiveCompletion: completed(with:), receiveValue: received(model:))
    }
    
    func getCountries() {
        let url = URL(string: "https://api.covid19api.com/countries")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        apiSubscriber = perform(request: request)
            .sink(receiveCompletion: completed(with:), receiveValue: received(model:))
    }
    
    func getStats(slug: String) {
        let url = URL(string: "https://api.covid19api.com/dayone/country/\(slug)/status/confirmed/live")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        apiSubscriber = perform(request: request)
            .sink(receiveCompletion: completed(with:), receiveValue: received(model:))
    }
    
    private func received(model: T) {
        state = .hasData(model: model)
    }
    
    private func completed(with completion: Subscribers.Completion<Error>) {
        
    }
    
    private func perform(request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(decode(result:))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func decode(result: URLSession.DataTaskPublisher.Output) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: result.data)
    }
}
