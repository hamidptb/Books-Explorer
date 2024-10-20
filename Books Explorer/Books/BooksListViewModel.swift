//
//  BooksListViewModel.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import Combine
import SwiftUI

class BooksListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var books: [Book] = []
    
    @Published var searchText: String = ""
    
    @Published private(set) var isFetching = false

    @Published private(set) var errorMessage: String?
    
    // MARK: - Dependencies

    private let apiService: APIService
    
    // MARK: - Subscription Management
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(apiService: APIService) {
        self.apiService = apiService
        
        fetchBooks()
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.fetchBooks(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Helper Methods
    
    func fetchBooks(searchText: String = "") {
        isFetching = true
        
        apiService.search(searchText: searchText)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                
                switch completion {
                case .finished:
                    print("Successfully Fetched Books")
                case .failure(let error):
                    print("Unable to Fetch Books \(error)")

                    self?.errorMessage = APIErrorMapper(
                        error: error,
                        context: .books
                    ).message
                }
            }, receiveValue: { [weak self] books in
                self?.books = books
            }).store(in: &cancellables)
    }
}
