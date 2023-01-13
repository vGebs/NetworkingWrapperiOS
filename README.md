# NetworkWrapperiOS

`NetworkWrapperiOS` is a networking wrapper class written in Swift that provides a simple and easy-to-use interface for making network requests. It's built on top of `URLSession` and it handles the response of the requests using closures.

## Features
- Supports GET, POST, PUT, PATCH and DELETE HTTP methods
- Automatically handles JSON decoding and encoding
- Simple and easy-to-use interface
- Provides two main functions:
    - `request(url:completion:)`: makes a request to the provided `URL` and returns the `Data` in the completion block
    - `request<T: Decodable>(url:completion:)`: makes a request to the provided `URL` and returns the decoded object of type T in the completion block

## Installation

### Swift Package Manager

You can install `NetworkWrapperiOS` using the [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, open your project and navigate to File > Swift Packages > Add Package Dependency.
2. Enter the repository URL `https://github.com/vGebs/NetworkingWrapperiOS.git` and click Next.
3. Select the version you want to install, or leave the default version and click Next.
4. In the "Add to Target" section, select the target(s) you want to use `NetworkWrapperiOS` in and click Finish.

## How to use

`NetworkWrapperiOS` is easy to use, you just need to create an instance of the class and call the desired function.
```swift
let networkWrapper = NetworkWrapper()
let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
let urlRequest = URLRequest(url: url)

// Using the non-generic request function
networkWrapper.request(with: urlRequest) { result in
    switch result {
    case .success(let data):
        print("Data: \(data)")
    case .failure(let error):
        print("Error: \(error)")
    }
}

// Using the generic request function
networkWrapper.request(with: urlRequest) { result in
    switch result {
    case .success(let users):
        print("Users: \(users)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```

You can use these functions inside your ViewControllers or other classes to handle the network requests.

## Error handling

NetworkWrapperiOS uses two optional parameters data: Data? and error: Error? to handle errors.

You can handle these errors in the completion block of the functions.

The `NetworkWrapper` uses a `Result` type to handle errors, it provides a `NetworkError` case that can contain the following errors:
- `invalidURL`: the provided `URL` is invalid
- `requestFailed`: the request failed
- `decodingFailed`: the decoding of the data failed

It's important to test the different error cases to ensure that the `NetworkWrapper` class handles them correctly and that your application can properly handle them.

## Testing

NetworkWrapperiOS is fully tested using the XCTest framework.

## Conclusion

`NetworkWrapper` is a useful tool that makes it easy to handle network requests in Swift, it's easy to use, test and customize. It makes the network requests handling more elegant, readable and maintainable.

## Note
This example uses `https://jsonplaceholder.typicode.com/users` an open JSON API that returns array of users, you can use it for testing and development purposes.

## Licensing

`NetworkWrapperiOS` is released under the MIT License.
