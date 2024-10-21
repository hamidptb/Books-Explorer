//
//  BookRowViewModelTest.swift
//  Books Explorer
//
//  Created by Hamid on 10/21/24.
//

import XCTest
@testable import Books_Explorer

class BookRowViewModelTest: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: BookRowViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        let data = loadStub(name: "search", extension: "json")
        
        let bookData = try! JSONDecoder().decode(BookResponse.self, from: data)

        viewModel = BookRowViewModel(book: bookData.items![1])
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // MARK: - Tests
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Building an Intelligent Web: Theory and Practice")
    }
    
    func testAuthorsName() {
        XCTAssertEqual(viewModel.authorsName, "Pawan Lingras, Rajendra Akerkar")
    }
    
    func testPublishedDate() {
        XCTAssertEqual(viewModel.publishedDate, "2007-10-17")
    }
}
