import XCTest
@testable import flux

final class fluxTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(flux().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
