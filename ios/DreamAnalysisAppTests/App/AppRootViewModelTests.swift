import XCTest
@testable import DreamAnalysisApp

final class AppRootViewModelTests: XCTestCase {
    func testDefaultTabIsHome() {
        let state = AppRootState()
        XCTAssertEqual(state.selectedTab, .home)
    }
}
