import XCTest
@testable import DreamAnalysisApp

final class SafeHarborViewModelTests: XCTestCase {
    func testSafeHarborHighlightsSinglePrimaryRefugeAction() {
        let model = SafeHarborViewModel(items: [.breathing])
        XCTAssertEqual(model.primaryItem, .breathing)
    }
}
