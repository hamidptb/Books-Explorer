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
    
    private var currentPage = 0
    
    var hasMorePages = true
    
    // MARK: - Details
    
    var bookRowViewModels: [BookRowViewModel] {
        books.map { BookRowViewModel(book: $0) }
    }
    
    // MARK: - Dependencies
    
    private let apiService: APIService
    
    // MARK: - Subscription Management
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init(apiService: APIService) {
        self.apiService = apiService
        
        fetchBooks()
    }
    
    // MARK: - Helper Methods
    
    func fetchBooks() {
        guard !isFetching, hasMorePages else { return }
        
        isFetching = true
        
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "all" : searchText
        
        let startIndex = currentPage * Environment.defaultMaxResult
        
        apiService.search(searchText: query, startIndex: startIndex)
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
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                self.books.append(contentsOf: value.items ?? [])
                self.currentPage += 1
                self.hasMorePages = (self.books.count) < value.totalItems
            }).store(in: &cancellables)
    }
    
    func refreshBooks() {
        books.removeAll()
        currentPage = 0
        hasMorePages = true
        
        fetchBooks()
    }
}
