//
//  APIError.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

enum APIError: Error {

    // MARK: - Cases

    case unknown
    case unreachable
    case unauthorized
    case failedRequest
    case invalidResponse

}
