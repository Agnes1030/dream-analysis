import XCTest
@testable import DreamAnalysisApp

final class InterpretationResultViewModelTests: XCTestCase {
    func testSaveMarksDreamAsArchivedAndPersistsArchiveDetails() {
        let dream = DreamEntry(
            rawTranscript: "I was floating above my house",
            followUpAnswer: "The light felt protective.",
            tags: ["floating", "home"],
            emotionalMarkers: ["safe", "curious"]
        )
        let result = Interpretation(
            coreInsight: "You are seeking distance.",
            symbolicSummary: "Elevation and home imagery.",
            personalReflection: "There may be a wish for perspective."
        )
        let model = InterpretationResultViewModel(dream: dream, interpretation: result)

        model.save()

        XCTAssertTrue(dream.isArchived)
        XCTAssertEqual(dream.followUpAnswer, "The light felt protective.")
        XCTAssertEqual(dream.interpretationSummary, "You are seeking distance.")
        XCTAssertEqual(dream.reflectionSnippet, "There may be a wish for perspective.")
        XCTAssertEqual(dream.tags, ["floating", "home"])
        XCTAssertEqual(dream.emotionalMarkers, ["safe", "curious"])
        XCTAssertTrue(model.didShowSavedConfirmation)
    }

    func testInterpretBuildsSymbolicSummaryWithoutPlaceholderOrCharacterCount() {
        let service = DreamInterpretationService()
        let dream = DreamEntry(rawTranscript: "I kept walking through a red hallway toward my grandmother's door")

        let interpretation = service.interpret(dream: dream)

        XCTAssertFalse(interpretation.symbolicSummary.contains("Placeholder"))
        XCTAssertFalse(interpretation.symbolicSummary.contains("characters"))
        XCTAssertTrue(interpretation.symbolicSummary.localizedCaseInsensitiveContains("door"))
        XCTAssertTrue(interpretation.symbolicSummary.localizedCaseInsensitiveContains("hallway"))
        XCTAssertTrue(interpretation.coreInsight.localizedCaseInsensitiveContains("family"))
    }

    func testInterpretUsesDifferentMotifsForDifferentDreamContent() {
        let service = DreamInterpretationService()

        let waterDream = service.interpret(dream: DreamEntry(rawTranscript: "I was wading through dark water while trying to reach the shore"))
        let flightDream = service.interpret(dream: DreamEntry(rawTranscript: "I was flying above bright rooftops and felt the sun on my face"))

        XCTAssertNotEqual(waterDream, flightDream)
        XCTAssertTrue(waterDream.symbolicSummary.localizedCaseInsensitiveContains("water"))
        XCTAssertTrue(flightDream.symbolicSummary.localizedCaseInsensitiveContains("height") || flightDream.symbolicSummary.localizedCaseInsensitiveContains("distance"))
        XCTAssertNotEqual(waterDream.coreInsight, flightDream.coreInsight)
    }

    func testInterpretUsesFollowUpAnswerToGroundPersonalReflection() {
        let service = DreamInterpretationService()
        let dream = DreamEntry(rawTranscript: "I kept opening doors in my childhood home")
        dream.followUpAnswer = "It reminded me of moving back in with my parents after a breakup."

        let interpretation = service.interpret(dream: dream)

        XCTAssertTrue(interpretation.personalReflection.localizedCaseInsensitiveContains("moving back in"))
        XCTAssertFalse(interpretation.personalReflection.localizedCaseInsensitiveContains("characters"))
    }

    func testCompleteLeavesDreamArchivedWhenAlreadySaved() {
        let dream = DreamEntry(rawTranscript: "A blue door")
        let result = Interpretation(coreInsight: "Insight", symbolicSummary: "Summary", personalReflection: "Reflection")
        let model = InterpretationResultViewModel(dream: dream, interpretation: result)

        model.save()
        model.complete()

        XCTAssertTrue(dream.isArchived)
        XCTAssertTrue(model.didShowSavedConfirmation)
    }
}
