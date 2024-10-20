//
//  APIService.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

import Combine
import Foundation

protocol APIService {

    // MARK: - Properties
    
    func search(searchText: String) -> AnyPublisher<[Book], APIError>
}
