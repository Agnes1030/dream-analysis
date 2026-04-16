import XCTest
@testable import DreamAnalysisApp

final class DreamEntryTests: XCTestCase {
    func testNewDreamEntryStartsUnsavedToArchive() {
        let entry = DreamEntry(rawTranscript: "I dreamed I was underwater")
        XCTAssertFalse(entry.isArchived)
    }

    func testDreamEntryPreservesArchiveDetailFields() {
        let entry = DreamEntry(
            rawTranscript: "I was standing in a quiet station.",
            followUpAnswer: "I felt relieved when the train finally arrived.",
            interpretationSummary: "The station may reflect a threshold in your waking life.",
            reflectionSnippet: "The waiting itself seemed to soften into trust.",
            tags: ["station", "threshold"],
            emotionalMarkers: ["relieved", "quiet"]
        )

        XCTAssertEqual(entry.rawTranscript, "I was standing in a quiet station.")
        XCTAssertEqual(entry.followUpAnswer, "I felt relieved when the train finally arrived.")
        XCTAssertEqual(entry.interpretationSummary, "The station may reflect a threshold in your waking life.")
        XCTAssertEqual(entry.reflectionSnippet, "The waiting itself seemed to soften into trust.")
        XCTAssertEqual(entry.tags, ["station", "threshold"])
        XCTAssertEqual(entry.emotionalMarkers, ["relieved", "quiet"])
    }
}
