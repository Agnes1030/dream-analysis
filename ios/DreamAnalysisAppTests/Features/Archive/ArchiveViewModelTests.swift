import XCTest
@testable import DreamAnalysisApp

final class ArchiveViewModelTests: XCTestCase {
    func testEmptyArchiveShowsInvitation() {
        let model = ArchiveViewModel(dreams: [])

        XCTAssertTrue(model.showsEmptyState)
        XCTAssertEqual(model.emptyStateTitle, "Archive")
        XCTAssertEqual(model.emptyStateMessage, "Saved dreams can rest here for a later return.")
    }

    func testInitSortsDreamsByDescendingCreatedAt() {
        let oldestDream = makeDream(rawTranscript: "Oldest dream", createdAt: Date(timeIntervalSince1970: 100))
        let newestDream = makeDream(rawTranscript: "Newest dream", createdAt: Date(timeIntervalSince1970: 300))
        let middleDream = makeDream(rawTranscript: "Middle dream", createdAt: Date(timeIntervalSince1970: 200))

        let model = ArchiveViewModel(dreams: [oldestDream, newestDream, middleDream])

        XCTAssertEqual(model.dreams.map(\.rawTranscript), ["Newest dream", "Middle dream", "Oldest dream"])
    }

    func testUpdateDreamsKeepsDescendingCreatedAtOrder() {
        let olderDream = makeDream(rawTranscript: "Older dream", createdAt: Date(timeIntervalSince1970: 100))
        let newerDream = makeDream(rawTranscript: "Newer dream", createdAt: Date(timeIntervalSince1970: 200))
        let model = ArchiveViewModel(dreams: [olderDream])

        model.updateDreams([olderDream, newerDream])

        XCTAssertEqual(model.dreams.map(\.rawTranscript), ["Newer dream", "Older dream"])
    }

    func testSelectDreamStoresSelectedDream() {
        let dream = makeDream(rawTranscript: "Selected dream", createdAt: Date(timeIntervalSince1970: 100))
        let model = ArchiveViewModel(dreams: [dream])

        model.selectDream(dream)

        XCTAssertEqual(model.selectedDream?.id, dream.id)
    }

    func testUpdateDreamsKeepsMatchingSelection() {
        let selectedDream = makeDream(rawTranscript: "Selected dream", createdAt: Date(timeIntervalSince1970: 100))
        let newerDream = makeDream(rawTranscript: "Newer dream", createdAt: Date(timeIntervalSince1970: 200))
        let model = ArchiveViewModel(dreams: [selectedDream])
        model.selectDream(selectedDream)

        model.updateDreams([selectedDream, newerDream])

        XCTAssertEqual(model.selectedDream?.id, selectedDream.id)
    }

    func testContinuitySummaryTreatsHomeAndHouseAsSharedMotif() throws {
        let earlierDream = makeDream(
            rawTranscript: "I stood outside my home by the river.",
            createdAt: Date(timeIntervalSince1970: 100),
            tags: ["home"]
        )
        let laterDream = makeDream(
            rawTranscript: "I walked back into the house at dusk.",
            createdAt: Date(timeIntervalSince1970: 200),
            tags: ["house"]
        )

        let model = ArchiveViewModel(dreams: [earlierDream, laterDream])
        let summary = try XCTUnwrap(model.continuitySummary)

        XCTAssertEqual(summary.motifSnapshot, "Recurring motifs: house")
    }

    func testContinuitySummaryReflectsMotifsEmotionsAndHistoryFraming() throws {
        let oldestDream = makeDream(
            rawTranscript: "I crossed a river toward a bright house.",
            createdAt: Date(timeIntervalSince1970: 100),
            emotionalMarkers: ["uneasy"],
            tags: ["river", "home"]
        )
        let newestDream = makeDream(
            rawTranscript: "I returned to the river and felt calm in the doorway.",
            createdAt: Date(timeIntervalSince1970: 300),
            emotionalMarkers: ["calm"],
            tags: ["river", "doorway"]
        )
        let middleDream = makeDream(
            rawTranscript: "The house was nearby again, and I felt hopeful.",
            createdAt: Date(timeIntervalSince1970: 200),
            emotionalMarkers: ["hopeful"],
            tags: ["house"]
        )

        let model = ArchiveViewModel(dreams: [oldestDream, newestDream, middleDream])
        let summary = try XCTUnwrap(model.continuitySummary)

        XCTAssertEqual(summary.title, "A living history")
        XCTAssertEqual(summary.motifSnapshot, "Recurring motifs: river, house")
        XCTAssertEqual(summary.emotionalDirection, "Recent emotional direction: calm, hopeful")
        XCTAssertEqual(summary.framing, "These dreams begin to trace a quieter thread over time, holding what seems to return.")
    }

    private func makeDream(
        rawTranscript: String,
        createdAt: Date,
        emotionalMarkers: [String] = [],
        tags: [String] = []
    ) -> DreamEntry {
        let dream = DreamEntry(rawTranscript: rawTranscript)
        dream.createdAt = createdAt
        dream.emotionalMarkers = emotionalMarkers
        dream.tags = tags
        return dream
    }
}
