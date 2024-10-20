//
//  BooksListView.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import SwiftUI

struct BooksListView: View {
    @ObservedObject var viewModel: BooksListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.authorName)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Books")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
