import XCTest
@testable import BetterErrors

final class BetterErrorsTests: XCTestCase {

    func testDescriptionWorks() {
      let error = NSError(domain: NSPOSIXErrorDomain, code: 2)
      XCTAssertEqual(error.betterDescription, "No such file or directory (2)")
    }

    func testOtherDomainWorks() {
      let error = NSError(domain: "Other domain", code: 123)
      XCTAssertEqual(error.betterDescription, "The operation could not be completed")
    }

    func testSuperLargeIntWorks() {
      let error = NSError(domain: NSPOSIXErrorDomain, code: Int.max)
      XCTAssertEqual(error.betterDescription, "The operation could not be completed")
    }

    func testThrowingWorks() {
      do {
        throw NSError(domain: NSPOSIXErrorDomain, code: 4)
      } catch {
        XCTAssertEqual(error.betterDescription, "Interrupted system call (4)")
      }
    }

    static var allTests = [
        ("testDescriptionWorks", testDescriptionWorks),
        ("testOtherDomainWorks", testOtherDomainWorks),
        ("testSuperLargeIntWorks", testSuperLargeIntWorks),
        ("testThrowingWorks", testThrowingWorks),
    ]
}
