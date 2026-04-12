import XCTest
@testable import DreamAnalysisApp

final class AppRootViewModelTests: XCTestCase {
    func testDefaultTabIsHome() {
        let state = AppRootState()
        XCTAssertEqual(state.selectedTab, .home)
    }

    func testAllTabsProvideNonEmptyShellMetadata() {
        for tab in AppTab.allCases {
            XCTAssertFalse(tab.title.isEmpty)
            XCTAssertFalse(tab.systemImageName.isEmpty)
        }
    }
}
