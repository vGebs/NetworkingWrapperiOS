//
//  File.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import SwiftUI

@available(iOS 13.0, *)
class TestViewModel: ObservableObject {
    private var test = SampleUsageService()
    
    func makeRequest() {
        let geo = Geo(lat: "50.0", lng: "-100.0")
        let address = Address(street: "main street", suite: "321", city: "Town", zipcode: "123", geo: geo)
        let company = Company(name: "TheCompany", catchPhrase: "we do it", bs: "")
        
        let user = User(
            id: 1,
            name: "test",
            username: "test1",
            email: "test@test.com",
            address: address,
            phone: "111-111-1111",
            website: "website.com",
            company: company
        )
        
        test.postUser(user: user) { result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print("failure: \(error)")
            }
        }
    }
    
    func makeDecodedRequest() {
        test.getUsers() { result in
            switch result {
            case .success(let users):
                // Handle successful response, users is an array of User objects
                for user in users {
                    print(user.name)
                }
            case .failure(let error):
                // Handle error
                switch error {
                case .invalidURL:
                    print("Invalid URL")
                case .invalidResponse:
                    print("Invalid Response")
                case .statusCode(let code):
                    print("Received status code: \(code)")
                case .decodingError:
                    print("Decoding Error")
                case .unexpectedError(let error):
                    print("Unexpected Error: \(error)")
                }
            }
        }
    }
}

@available(iOS 13.0.0, *)
struct ContentView: View {
    @StateObject var test = TestViewModel()
    
    var body: some View {
        VStack {
            Button(action: { test.makeRequest() }) {
                Text("Make simple request")
            }.padding(30)
            
            Button(action: { test.makeDecodedRequest() }) {
                Text("Make a decoded request")
            }.padding(30)
        }
        .padding()
    }
}

@available(iOS 13.0.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

