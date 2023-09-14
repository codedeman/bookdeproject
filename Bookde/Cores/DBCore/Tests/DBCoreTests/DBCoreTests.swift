import XCTest
@testable import DBCore

final class DBCoreTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DBCore().text, "Hello, World!")
    }
}
