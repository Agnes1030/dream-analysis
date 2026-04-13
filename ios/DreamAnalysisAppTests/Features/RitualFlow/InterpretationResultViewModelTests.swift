import XCTest
@testable import DreamAnalysisApp

final class InterpretationResultViewModelTests: XCTestCase {
    func testSaveMarksDreamAsArchived() {
        let dream = DreamEntry(rawTranscript: "I was floating above my house")
        let result = Interpretation(coreInsight: "You are seeking distance.", symbolicSummary: "Elevation and home imagery.", personalReflection: "There may be a wish for perspective.")
        let model = InterpretationResultViewModel(dream: dream, interpretation: result)

        model.save()

        XCTAssertTrue(dream.isArchived)
        XCTAssertTrue(model.didShowSavedConfirmation)
    }

    func testInterpretUsesDreamTranscriptInOutputContract() {
        let service = DreamInterpretationService()
        let dream = DreamEntry(rawTranscript: "I kept walking through a red hallway toward my grandmother's door")

        let interpretation = service.interpret(dream: dream)

        XCTAssertTrue(interpretation.coreInsight.contains("red hallway toward my grandmother's door"))
        XCTAssertTrue(interpretation.symbolicSummary.contains("65 characters"))
        XCTAssertTrue(interpretation.personalReflection.contains("I kept walking through a red hallway toward my grandmother's door"))
    }

    func testInterpretChangesWhenDreamTranscriptChanges() {
        let service = DreamInterpretationService()

        let first = service.interpret(dream: DreamEntry(rawTranscript: "I was running through rain"))
        let second = service.interpret(dream: DreamEntry(rawTranscript: "I was asleep in sunlight"))

        XCTAssertNotEqual(first, second)
    }
}
