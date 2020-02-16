import XCTest
@testable import Constants

final class ConstantsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Constants().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
