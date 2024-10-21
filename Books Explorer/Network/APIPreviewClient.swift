//
//  APIPreviewClient.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

import Combine
import Foundation

struct APIPreviewClient: APIService {
    
    // MARK: - Methods
    
    func search(searchText: String, startIndex: Int) -> AnyPublisher<BookResponse, APIError> {
        publisher(for: "search")
    }
}

fileprivate extension APIPreviewClient {

    func publisher<T: Decodable>(for resource: String) -> AnyPublisher<T, APIError> {
        Just(stubData(for: resource))
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func stubData<T: Decodable>(for resource: String) -> T {
        guard
            let url = Bundle.main.url(forResource: resource, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let stubData = try? JSONDecoder().decode(T.self, from: data)
        else {
            fatalError("Unable to Load Stub Data")
        }

        return stubData
    }

}
