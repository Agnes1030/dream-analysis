import XCTest
@testable import DreamAnalysisApp

final class PrivateWhispersViewModelTests: XCTestCase {
    func testPrivateWhispersPrefersSingleFeaturedWhisper() {
        let whispers = [PrivateWhisper(featuredText: "You have been circling the same door in different dreams.")]
        let model = PrivateWhispersViewModel(whispers: whispers)
        XCTAssertEqual(model.featuredWhisper?.featuredText, "You have been circling the same door in different dreams.")
    }
}
