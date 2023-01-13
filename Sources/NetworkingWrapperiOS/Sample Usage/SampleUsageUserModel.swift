//
//  SampleUsageUserModel.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import Foundation

struct User: Decodable, Encodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Decodable, Encodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Decodable, Encodable {
    let lat: String
    let lng: String
}

struct Company: Decodable, Encodable {
    let name: String
    let catchPhrase: String
    let bs: String
}
