import XCTest
@testable import DreamAnalysisApp

final class AppTabTests: XCTestCase {
    func testStableTabsMatchApprovedV1Structure() {
        XCTAssertEqual(AppTab.allCases, [.home, .patterns, .archive, .me])
    }

    func testTabTitlesMatchApprovedShellMetadata() {
        XCTAssertEqual(AppTab.home.title, "Home")
        XCTAssertEqual(AppTab.patterns.title, "Patterns")
        XCTAssertEqual(AppTab.archive.title, "Archive")
        XCTAssertEqual(AppTab.me.title, "Me")
    }

    func testTabSystemImageNamesMatchApprovedShellMetadata() {
        XCTAssertEqual(AppTab.home.systemImageName, "moon.stars")
        XCTAssertEqual(AppTab.patterns.systemImageName, "sparkles.rectangle.stack")
        XCTAssertEqual(AppTab.archive.systemImageName, "tray.full")
        XCTAssertEqual(AppTab.me.systemImageName, "person")
    }
}
