//
//  DataRequest.swift
//  Chip_test
//
//  Created by hanif hussain on 21/02/2024.
//

import Foundation
import Combine

enum JsonError: Error {
    case failedRequest
}

class DataProvider {
    private var request = Set<AnyCancellable>()
    
    // using generic type and combine swift will figure out the type from the decodable we pass or from our comletion closure when we if and when we specify T
    func fetchRequest<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true // wait for device to have active connection
        
        URLSession.shared.dataTaskPublisher(for: url)
        // create a pipeline of functions
            .retry(1) // retry once as it is expensive to make network calls
            .map(\.data) // pull out just the data
            .decode(type: T.self, decoder: decoder) // decode the data to user using our decoder defined above as generic type T
            .replaceError(with: defaultValue) // replace error with our default value, we could instead use try map and handle errors if we do not want to pass a default value
            .receive(on: DispatchQueue.main) // receive on main as we would like to perform some ui actions
            .sink(receiveValue: completion) // get back the value / sink
            .store(in: &request)
    }
    
    // created a specific fetch dogs func as this will be called when we
    func fetchDogs(_ url: URL, completion: @escaping (Dogs) -> Void) {
        let decoder = JSONDecoder()
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true // wait for device to have active connection
        
        URLSession(configuration: config).dataTaskPublisher(for: url)
            .retry(1) // retry once as it is expensive to make network calls
        // let's try map the data as Dogs struct ( we will escape on failure as something may be wrong with Json
            .tryMap { data, response -> Dogs in
                // let verify the response, if it is in the range of 200 to less than 300 then it is a ok response let's proceed
                guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode)
                // bad response throw error
                else { throw JsonError.failedRequest}
                // Return decoded dogs
                return try decoder.decode(Dogs.self, from: data)
            }
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: // finished
                    print()
                case .failure(let error): // handle sink failure
                    print("failure to sink \(error)")
                }
            }, receiveValue: { data in
                completion(data) // escaping closure to capture data
            })
            .store(in: &request)
    }
}
