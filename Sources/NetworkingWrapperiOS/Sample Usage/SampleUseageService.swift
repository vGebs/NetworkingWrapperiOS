//
//  SampleUsageService.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import Foundation

@available(iOS 13.0, *)
class SampleUsageService: ObservableObject {
    let network = NetworkWrapper()
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    func makeRequest(){
        network.request(url: url) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                print("Data: \(data)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func makeDecodedRequest(){
        network.request(url: url) { (result: Result<[User], NetworkError>) in
            switch result {
            case .success(let users):
                print("Users: \(users)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
