import XCTest
@testable import DreamAnalysisApp

final class ProfileViewModelTests: XCTestCase {
    func testProfileSurfacesMemoryControls() {
        let model = ProfileViewModel()
        XCTAssertTrue(model.showsMemoryControls)
    }

    func testExplanationStringsProvideExpectedOrderedCopy() {
        let model = ProfileViewModel()

        XCTAssertEqual(
            model.explanationStrings,
            [
                "Your dream history can stay quietly in step across devices when you choose to keep it.",
                "Raw dream details can remain close to you, while only the context needed for interpretation is shared.",
                "Memory helps the app notice returning symbols, feelings, and places so each reflection can feel more familiar over time."
            ]
        )
    }
}
