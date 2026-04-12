import XCTest
@testable import DreamAnalysisApp

final class DreamEntryTests: XCTestCase {
    func testNewDreamEntryStartsUnsavedToArchive() {
        let entry = DreamEntry(rawTranscript: "I dreamed I was underwater")
        XCTAssertFalse(entry.isArchived)
    }
}
