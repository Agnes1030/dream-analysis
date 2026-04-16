import XCTest
@testable import DreamAnalysisApp

final class ProfileViewModelTests: XCTestCase {
    func testProfileSurfacesMemoryControls() {
        let model = ProfileViewModel(patternSummary: .earlyUse)
        XCTAssertTrue(model.showsMemoryControls)
    }

    func testDefaultsKeepContinuityControlsEnabled() {
        let model = ProfileViewModel(patternSummary: .earlyUse)

        XCTAssertTrue(model.usePriorPatternsInInterpretation)
        XCTAssertTrue(model.surfaceContinuityCuesOnReturn)
    }

    func testMemorySectionRowsProvideExpectedOrderedCopyAndStructure() {
        let summary = PatternSummary(
            title: "Your dream language is beginning to gather",
            detail: "A few threads are starting to repeat.",
            stage: .established,
            trajectorySummary: "A steadier feeling of agency is beginning to hold across transitions.",
            recurringSymbols: [
                .init(id: "water", name: "Water", note: "It often appears when feelings are close to the surface."),
                .init(id: "doorway", name: "Doorways", note: "They tend to show up at moments of transition."),
                .init(id: "station", name: "Train stations", note: "They appear when something is waiting to move.")
            ]
        )
        let model = ProfileViewModel(patternSummary: summary)

        XCTAssertEqual(
            model.memorySectionRows,
            [
                .control(
                    title: "Use prior patterns",
                    detail: "Use prior patterns in later interpretations when it helps add continuity.",
                    isEnabled: true
                ),
                .control(
                    title: "Surface continuity cues",
                    detail: "Surface gentle continuity cues when you return, like familiar symbols or emotional threads.",
                    isEnabled: true
                ),
                .infoCard(
                    title: "What the app is noticing",
                    detail: "It is currently noticing Water, Doorways and Train stations, along with a broader shift: A steadier feeling of agency is beginning to hold across transitions."
                ),
                .infoCard(
                    title: "What memory is in use right now",
                    detail: "Right now this app uses a local pattern summary drawn from your recurring symbols and trajectory, not full account sync."
                ),
                .explanation(
                    title: "Privacy",
                    detail: "Raw dream details do not need to travel far for this page to be useful. What appears here is a compact continuity summary, not a complete replay of everything you shared."
                ),
                .explanation(
                    title: "Account and sync",
                    detail: "Account and sync can grow into continuity infrastructure later. In this version, your controls stay on this device and your memory summary stays intentionally small."
                )
            ]
        )
    }

    func testRememberedSummaryDerivesWhatAppIsNoticingFromPatternData() {
        let summary = PatternSummary(
            title: "Your dream language is beginning to gather",
            detail: "A few threads are starting to repeat.",
            stage: .established,
            trajectorySummary: "Water and doorways keep returning with more calm than before.",
            recurringSymbols: [
                .init(id: "water", name: "Water", note: "It often appears when feelings are close to the surface."),
                .init(id: "doorway", name: "Doorways", note: "They tend to show up at moments of transition.")
            ]
        )
        let model = ProfileViewModel(patternSummary: summary)

        XCTAssertEqual(model.noticingSectionTitle, "What the app is noticing")
        XCTAssertEqual(
            model.noticingSummary,
            "It is currently noticing Water and Doorways, along with a broader shift: Water and doorways keep returning with more calm than before."
        )
    }

    func testRememberedSummaryFallsBackToTrajectoryWhenNoSymbolsExist() {
        let summary = PatternSummary(
            title: "Still early",
            detail: "The pattern is light.",
            stage: .early,
            trajectorySummary: "A quieter sense of safety is beginning to return.",
            recurringSymbols: []
        )
        let model = ProfileViewModel(patternSummary: summary)

        XCTAssertEqual(
            model.noticingSummary,
            "It is currently holding one early continuity note: A quieter sense of safety is beginning to return."
        )
    }
}
