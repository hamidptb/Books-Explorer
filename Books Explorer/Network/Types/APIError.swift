//
//  APIError.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

enum APIError: Error {
    
    // MARK: - Cases
    
    case unauthorized
    case unreachable
    case failedRequest
    case invalidResponse
    case unknown
    case tooManyRequests
    case badRequest
    case forbidden
    
}
