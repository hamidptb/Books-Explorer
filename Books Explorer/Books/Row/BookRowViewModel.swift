//
//  BookRowViewModel.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import Combine
import Foundation

class BookRowViewModel: ObservableObject, Identifiable {

    // MARK: - Properties

    let book: Book

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
    
    var publishedDate: String {
        book.volumeInfo.publishedDate ?? "-"
    }
    
    var smallThumbnail: String {
//        book.volumeInfo.imageLinks?.smallThumbnail ?? "-"
        "https://m.media-amazon.com/images/I/61dGkbaw9QL._AC_UF1000,1000_QL80_.jpg"
    }
    
    // MARK: - Initialization

    init(book: Book) {
        self.book = book
    }
}
