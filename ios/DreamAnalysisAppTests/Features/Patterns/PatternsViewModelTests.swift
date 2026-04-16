import XCTest
@testable import DreamAnalysisApp

final class PatternsViewModelTests: XCTestCase {
    func testEarlyStateExplainsGrowthAndKeepsSparseSectionsGentle() {
        let model = PatternsViewModel(patternSummary: .earlyUse)

        XCTAssertTrue(model.shouldExplainGrowth)
        XCTAssertEqual(model.trajectoryTitle, "How your dream story is moving")
        XCTAssertEqual(model.peoplePlacesRows, [])
        XCTAssertNil(model.emotionalTrendSummary)
        XCTAssertNil(model.profileReflection)
        XCTAssertNil(model.recentThemeSummary)
    }

    func testEstablishedStateExposesRicherContinuitySections() {
        let model = PatternsViewModel(patternSummary: .establishedUse)

        XCTAssertFalse(model.shouldExplainGrowth)
        XCTAssertEqual(model.recurringSymbols.count, 2)
        XCTAssertEqual(
            model.peoplePlacesRows.map(\.title),
            ["Recurring people", "Recurring places"]
        )
        XCTAssertEqual(model.peoplePlacesRows.first?.items, ["Your sister", "A quiet guide"])
        XCTAssertEqual(model.peoplePlacesRows.last?.items, ["Childhood home", "Train platforms"])
        XCTAssertEqual(model.emotionalTrendSummary, "The emotional tone is shifting from urgency toward steadier forms of concern and care.")
        XCTAssertEqual(model.profileReflection, "Your dreams often return to moments of transition, but they are becoming less about being lost inside them and more about staying present while they unfold.")
        XCTAssertEqual(model.recentThemeSummary, "Recently, your dreams seem to be circling questions of return, responsibility, and how to move without abandoning yourself.")
    }

    func testSparseEstablishedSummaryHidesEmptySectionsGracefully() {
        let model = PatternsViewModel(patternSummary: .sparseEstablishedUse)

        XCTAssertFalse(model.shouldExplainGrowth)
        XCTAssertEqual(model.recurringSymbols.count, 1)
        XCTAssertEqual(model.peoplePlacesRows, [])
        XCTAssertNil(model.emotionalTrendSummary)
        XCTAssertEqual(model.profileReflection, "A steadier shape is beginning to appear, even if it is still too early to name it too firmly.")
        XCTAssertNil(model.recentThemeSummary)
    }
}

private extension PatternSummary {
    static let sparseEstablishedUse = PatternSummary(
        title: "A more continuous dream story is starting to appear",
        detail: "There is enough repetition to sense continuity, even where the picture is still incomplete.",
        stage: .established,
        trajectorySummary: "A few images are recurring often enough to suggest an emerging thread.",
        recurringSymbols: [
            RecurringSymbol(
                id: "bridge",
                name: "Bridge",
                note: "It appears around crossings and tentative change."
            )
        ],
        recurringPeople: [],
        recurringPlaces: [],
        emotionalTrendSummary: nil,
        profileReflection: "A steadier shape is beginning to appear, even if it is still too early to name it too firmly.",
        recentThemeSummary: nil
    )
}
