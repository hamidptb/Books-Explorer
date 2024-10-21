//
//  APIClient.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

import Combine
import Foundation

class APIClient: APIService {
    
    // MARK: - API Service
    
    func search(searchText: String, startIndex: Int) -> AnyPublisher<BookResponse, APIError> {
        request(.search(searchText: searchText, startIndex: startIndex))
    }
    
    // MARK: - Helper Methods
    
    private func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        do {
            let request = try endpoint.request()

            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response -> T in
                    print(String(decoding: data, as: UTF8.self))
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.failedRequest
                    }

                    // Handle specific status codes
                    switch statusCode {
                    case 200..<300:
                        break // Success
                    case 400:
                        throw APIError.badRequest
                    case 401:
                        throw APIError.unauthorized
                    case 403:
                        throw APIError.forbidden
                    case 429:
                        throw APIError.tooManyRequests
                    default:
                        throw APIError.failedRequest
                    }

                    if statusCode == 204, let noContent = NoContent() as? T {
                        return noContent
                    }

                    do {
                        return try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        print("Unable to Decode Response \(error)")
                        throw APIError.invalidResponse
                    }
                }
                .mapError { error -> APIError in
                    switch error {
                    case let apiError as APIError:
                        return apiError
                    case URLError.notConnectedToInternet:
                        return APIError.unreachable
                    default:
                        return APIError.failedRequest
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            if let apiError = error as? APIError {
                return Fail(error: apiError)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
        }
    }
}
