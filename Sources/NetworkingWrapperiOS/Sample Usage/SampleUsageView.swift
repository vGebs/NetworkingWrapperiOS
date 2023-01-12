//
//  File.swift
//  
//
//  Created by Vaughn on 2023-01-12.
//

import SwiftUI

@available(iOS 13.0.0, *)
struct ContentView: View {
    @StateObject var test = SampleUsageService()
    
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

