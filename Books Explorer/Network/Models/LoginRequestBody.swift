//
//  LoginRequestBody.swift
//  Network Manager SwiftUi
//
//  Created by Hamid on 10/20/24.
//

struct LoginRequestBody: Codable {
    let username: String
    let password: String
    let expiresInMins: Int
}
