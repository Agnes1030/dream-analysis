import XCTest
@testable import DreamAnalysisApp

final class HomeViewModelTests: XCTestCase {
    func testPrimaryActionLaunchesSharedCaptureFlow() {
        let model = HomeViewModel()
        let coordinator = RitualFlowCoordinator()

        model.didTapCapture(using: coordinator)

        XCTAssertTrue(coordinator.isPresentingFlow)
        XCTAssertEqual(coordinator.step, .capture)
    }
}
