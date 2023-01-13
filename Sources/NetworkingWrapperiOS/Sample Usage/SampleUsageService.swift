//
//  SampleUsageService.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import Foundation

@available(iOS 13.0, *)
class SampleUsageService {
    private let networkWrapper = NetworkWrapper()
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!

    func getUsers(completion: @escaping (Result<[User], NetworkWrapper.NetworkError>) -> Void) {
        let request = URLRequest(url: baseURL.appendingPathComponent("users"))
        networkWrapper.request(with: request) { (result: Result<[User], NetworkWrapper.NetworkError>) in
            completion(result)
        }
    }
    
    func postUser(user: User, completion: @escaping (Result<Void, NetworkWrapper.NetworkError>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("users"))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        networkWrapper.request(with: request) { (result: Result<Data, NetworkWrapper.NetworkError>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

