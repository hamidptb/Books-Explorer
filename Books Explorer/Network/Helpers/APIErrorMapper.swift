//
//  APIErrorMapper.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

import Foundation

struct APIErrorMapper {

    // MARK: - Types

    enum Context {
        case books
    }

    // MARK: - Properties

    let error: APIError
    let context: Context

    // MARK: - Public API

    var message: String {
        switch error {
        case .unreachable:
            return "You need to have a network connection."
        case .unauthorized:
            switch context {
            case .books:
                return "You need to be signed in to view books."
            }
            
        case .unknown,
             .failedRequest,
             .invalidResponse:
            switch context {
            case .books:
                return "The list of books could not be fetched."
            }
            
        case .tooManyRequests:
            switch context {
            case .books:
                return "You've made too many requests. Please try again later."
            }
            
        case .badRequest:
            switch context {
            case .books:
                return "The request was invalid. Please check and try again. (check your inserted search text)"
            }
        case .forbidden:
            switch context {
            case .books:
                return "You have forbidden access to this resource. Use DNS"
            }
        }
    }
}
