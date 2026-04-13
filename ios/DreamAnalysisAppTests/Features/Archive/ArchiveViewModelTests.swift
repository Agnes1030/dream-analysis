import XCTest
@testable import DreamAnalysisApp

final class ArchiveViewModelTests: XCTestCase {
    func testEmptyArchiveShowsInvitation() {
        let model = ArchiveViewModel(dreams: [])

        XCTAssertTrue(model.showsEmptyState)
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

    private func makeDream(rawTranscript: String, createdAt: Date) -> DreamEntry {
        let dream = DreamEntry(rawTranscript: rawTranscript)
        dream.createdAt = createdAt
        return dream
    }
}
