import XCTest
@testable import DreamAnalysisApp

final class HomeViewModelTests: XCTestCase {
    func testPrimaryActionLaunchesCaptureFlow() {
        let model = HomeViewModel()
        model.didTapCapture()
        XCTAssertTrue(model.isPresentingCapture)
    }
}
