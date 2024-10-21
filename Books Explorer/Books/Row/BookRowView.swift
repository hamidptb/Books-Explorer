//
//  BooksRowView.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import SwiftUI

struct BookRowView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: BookRowViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: viewModel.tempImageUrl)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 85)
                
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(viewModel.authorsName)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text(viewModel.publishedDate)
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .opacity(0.7)
            }
            
            Spacer()
        }
    }
}

#Preview {
    BookRowView(viewModel: BookRowViewModel(book: BookResponse.bookResponse.items![1]))
        .background(.yellow)
        .padding()
}
