import XCTest
@testable import DreamAnalysisApp

final class PatternsViewModelTests: XCTestCase {
    func testEarlyUseStateShowsLimitedPatterns() {
        let model = PatternsViewModel(patternSummary: .earlyUse)
        XCTAssertTrue(model.shouldExplainGrowth)
    }
}
