//
//  BookModel.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

struct Book: Codable, Identifiable {
    let id: Int
    let title: String
    let authorName: String
    let firstPublishYear: Int
    let coverId: String
    let image: String
    let description: String
}
