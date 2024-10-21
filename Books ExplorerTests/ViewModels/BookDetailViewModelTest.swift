//
//  BookDetailViewModelTest.swift
//  Books Explorer
//
//  Created by Hamid on 10/21/24.
//

import XCTest
@testable import Books_Explorer

class BookDetailViewModelTest: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: BookDetailViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUpWithError() throws {
        let data = loadStub(name: "search", extension: "json")
        
        let bookData = try! JSONDecoder().decode(BookResponse.self, from: data)

        viewModel = BookDetailViewModel(book: bookData.items![1])
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
    
    func testPublisher() {
        XCTAssertEqual(viewModel.publisher, "Jones & Bartlett Publishers")
    }
    
    func testPageCount() {
        XCTAssertEqual(viewModel.pageCount, 340)
    }
    
    func testLanguage() {
        XCTAssertEqual(viewModel.language, "EN")
    }
    
    func testContentVersion() {
        XCTAssertEqual(viewModel.contentVersion, "2.3.4.0")
    }
    
    func testDescription() {
        XCTAssertEqual(viewModel.description, "The World Wide Web has become an extremely popular way of publishing and distributing electronic resources. Though the Web is rich with information, collecting and making sense of this data is difficult because it is rather unorganized. Building an Intelligent Web introduces students and professionals to the state-of-the art development of Web Intelligence techniques and teaches how to apply these techniques to develop the next generation of intelligent Web sites. Each chapter contains theoretical bases, which are also illustrated with the help of simple numeric examples, followed by practical implementation. Students will find Building an Intelligent Web to be an active and exciting introduction to advanced Web mining topics. Topics covered include Web Intelligence, Information Retrieval, Semantic Web, Classification and Association Rules, SQL, Database Theory, Applications to e-commerce and Bioinformatics, Clustering, Modeling Web Topology, and much more!")
    }
    
//    var contentVersion: String {
//        if let contentVersion = book.volumeInfo.contentVersion {
//            return String(contentVersion.prefix(7))
//        } else {
//            return "-"
//        }
//    }
}
