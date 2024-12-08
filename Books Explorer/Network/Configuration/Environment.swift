//
//  Environment.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

import Foundation

enum Environment {

    static var apiBaseURL: URL {
        URL(string: "https://www.googleapis.com")!
    }
    
    static var defaultMaxResult: Int {
        10
    }
}
