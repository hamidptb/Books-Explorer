//
//  BookDetailViewModel.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import Foundation

class BookDetailViewModel: ObservableObject {
    
    // MARK: - Properties

    private let book: Book

    // MARK: - Details
    
    var id: String {
        book.id
    }
    
    var title: String {
        book.volumeInfo.title ?? "-"
    }
    
    var authorsName: String {
        if let authors = book.volumeInfo.authors {
            return authors.joined(separator: ", ")
        }
        return "-"
    }
    
    var publisher: String {
        book.volumeInfo.publisher ?? "-"
    }
    
    var publishedDate: String {
        book.volumeInfo.publishedDate ?? "-"
    }
    
    var thumbnail: String {
        return book.volumeInfo.imageLinks?.thumbnail ?? ""
//        "https://m.media-amazon.com/images/I/61dGkbaw9QL._AC_UF1000,1000_QL80_.jpg"
    }
    
    var pageCount: Int {
        book.volumeInfo.pageCount ?? 0
    }
    
    var language: String {
        book.volumeInfo.language?.uppercased() ?? "-"
    }
    
    var contentVersion: String {
        if let contentVersion = book.volumeInfo.contentVersion {
            return String(contentVersion.prefix(7))
        } else {
            return "-"
        }
    }
    
    var description: String {
        book.volumeInfo.description ?? "-"
    }
    
    // MARK: - Initialization
    
    init(book: Book) {
        self.book = book
    }
    
}
