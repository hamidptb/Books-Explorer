//
//  BooksListView.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import SwiftUI

struct BooksListView: View {
    @ObservedObject var viewModel: BooksListViewModel
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.bookRowViewModels.isEmpty && !viewModel.isFetching {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .font(.headline)
                } else {
                    booksList
                }
                
                if viewModel.isFetching {
                    ProgressView("Loading...")
                        .progressViewStyle(.circular)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(Constant.Size.defaultCornerRadius)
                }
            }
            .navigationTitle("Books")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                viewModel.refreshBooks()
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown Error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        // Handle cancel tapped in search bar
        .onChange(of: viewModel.searchText) {
            if viewModel.searchText.isEmpty {
                viewModel.searchText = ""
                viewModel.refreshBooks()
            }
        }
        .onChange(of: viewModel.errorMessage) {
            if viewModel.errorMessage != nil {
                showingAlert = true
            }
        }
    }
    
    // MARK: - booksList
    
    var booksList: some View {
        List {
            ForEach(viewModel.bookRowViewModels) { bookRowViewModel in
                NavigationLink {
                    BookDetailView(viewModel: BookDetailViewModel(book: bookRowViewModel.book))
                } label: {
                    BookRowView(viewModel: bookRowViewModel)
                }
                // Pagination
                .onAppear {
                    if bookRowViewModel.id == viewModel.books.last?.id {
                        viewModel.fetchBooks()
                    }
                }
            }
        }
        .refreshable {
            if !viewModel.isFetching {
                viewModel.refreshBooks()
            }
        }
    }
}

#Preview {
    BooksListView(viewModel: BooksListViewModel(apiService: APIPreviewClient()))
}
