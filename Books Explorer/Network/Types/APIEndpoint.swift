//
//  APIEndpoint.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

import Foundation

enum APIEndpoint {

    // MARK: - Cases
    
    case search(searchText: String, startIndex: Int)
    
    // MARK: - Properties

    func request() throws -> URLRequest {
        var request = URLRequest(url: url)

        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody

        return request
    }
    
    private var url: URL {
        var components = URLComponents(url: Environment.apiBaseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = params
        return components.url!
    }
    
    private var path: String {
        switch self {
        case .search:
            return "/books/v1/volumes"
        }
    }
    
    private var params: [URLQueryItem]? {
        switch self {
        case .search(let searchText, let startIndex):
            let formattedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
            return [URLQueryItem(name: "q", value: formattedSearchText),
                    URLQueryItem(name: "maxResults", value: "\(Environment.defaultMaxResult)"),
                    URLQueryItem(name: "startIndex", value: "\(startIndex)")]
        }
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }

    private var httpBody: Data? {
        switch self {
        case .search:
            return nil
        }
    }
    
    private var headers: Headers {
        switch self {
        case .search:
            return ["Content-Type": "application/json"]
        }
    }
}

extension URLRequest {

    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }

}
