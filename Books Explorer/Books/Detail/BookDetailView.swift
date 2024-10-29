//
//  BookDetailView.swift
//  Books Explorer
//
//  Created by Hamid on 10/20/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailView: View {
    
    // MARK: - Properties
    
    let viewModel: BookDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                info
                
                Divider()
                
                attribute
                
                Divider()
                
                description
            }
        }
        .padding()
        .navigationTitle("Details")
    }
    
    // MARK: - info
    
    var info: some View {
        HStack {
            WebImage(url: URL(string: viewModel.thumbnail)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 170)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("Authors: " + viewModel.authorsName)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text("Publisher: " + viewModel.publisher)
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(.gray)
                    .opacity(0.7)
                    .lineLimit(2)
            }
        }
    }
    
    // MARK: - attribute
    
    var attribute: some View {
        HStack(spacing: 40) {
            AttributeView(title: "Version", image: "number", text: viewModel.contentVersion)
            AttributeView(title: "Language", image: "translate", text: viewModel.language)
            AttributeView(title: "Pages", image: "book.pages", text: String(viewModel.pageCount))
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func AttributeView(title: String, image: String, text: String) -> some View {
        VStack {
            Text(title)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
            
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 25)
            
            Text(text)
        }
        .font(.system(size: 17, weight: .medium))
        .padding(8)
        .frame(width: 80)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.primary, lineWidth: 1)
        )
    }
    
    // MARK: - description
    
    var description: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.primary)
            
            Text(viewModel.description)
        }
    }
}

#Preview {
    BookDetailView(viewModel: BookDetailViewModel(book: BookResponse.bookResponse.items![1]))
}
