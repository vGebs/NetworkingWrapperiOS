import XCTest
@testable import NetworkingWrapperiOS

class NetworkWrapperTests: XCTestCase {
    let networkWrapper = NetworkWrapper()
    let usersUrl = URL(string: "https://jsonplaceholder.typicode.com/users")!

    func testRequestData() {
        let expectation = self.expectation(description: "Request data")

        networkWrapper.request(with: URLRequest(url: usersUrl)) { result in
            switch result {
            case .success(let data):
                XCTAssert(data.count > 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRequestDecodable() {
        let expectation = self.expectation(description: "Request decodable")

        networkWrapper.request(with: URLRequest(url: usersUrl)) { result in
            switch result {
            case .success(let users):
                XCTAssert(users.count > 0)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
