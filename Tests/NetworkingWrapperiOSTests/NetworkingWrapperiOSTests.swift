import XCTest
@testable import NetworkingWrapperiOS

class NetworkWrapperTests: XCTestCase {
    var networkWrapper: NetworkWrapper!
    var testUrl: URL!

    override func setUp() {
        super.setUp()
        networkWrapper = NetworkWrapper()
        testUrl = URL(string: "https://jsonplaceholder.typicode.com/users")!
    }

    override func tearDown() {
        networkWrapper = nil
        testUrl = nil
        super.tearDown()
    }

    func testRequestData() {
        let expectation = self.expectation(description: "Request should succeed")
        networkWrapper.request(url: testUrl) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
                expectation.fulfill()
            case .failure:
                XCTFail("Request should succeed")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRequestDecodable() {
        let expectation = self.expectation(description: "Request should succeed")
        networkWrapper.request(url: testUrl) { (result: Result<[User], NetworkError>) in
            switch result {
            case .success(let users):
                XCTAssertNotNil(users, "Users should not be nil")
                expectation.fulfill()
            case .failure:
                XCTFail("Request should succeed")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
