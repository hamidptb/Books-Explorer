//
//  Books_ExplorerApp.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import SwiftUI

@main
struct Books_ExplorerApp: App {
    var body: some Scene {
        WindowGroup {
//            BooksListView(viewModel: BooksListViewModel(apiService: APIPreviewClient()))
            BooksListView(viewModel: BooksListViewModel(apiService: APIClient()))
        }
    }
}
