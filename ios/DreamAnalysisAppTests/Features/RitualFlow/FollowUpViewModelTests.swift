import XCTest
@testable import DreamAnalysisApp

final class FollowUpViewModelTests: XCTestCase {
    func testSelectOptionSetsAnswerAndCompletes() {
        let prompt = FollowUpPrompt(id: "mood", prompt: "How did it feel?", inputStyle: .chips, options: ["uneasy"])
        let model = FollowUpViewModel(prompt: prompt)

        model.selectOption("uneasy")

        XCTAssertEqual(model.answer, "uneasy")
        XCTAssertTrue(model.isComplete)
    }

    func testSubmitTextAnswerStoresTrimmedTextAndCompletes() {
        let prompt = FollowUpPrompt(id: "details", prompt: "What stood out?", inputStyle: .text, options: [])
        let model = FollowUpViewModel(prompt: prompt)

        model.submitTextAnswer("  bright hallway  ")

        XCTAssertEqual(model.answer, "bright hallway")
        XCTAssertTrue(model.isComplete)
    }

    func testSubmitTextAnswerIgnoresWhitespaceOnlyInputAndDoesNotComplete() {
        let prompt = FollowUpPrompt(id: "details", prompt: "What stood out?", inputStyle: .text, options: [])
        let model = FollowUpViewModel(prompt: prompt)

        model.submitTextAnswer("  \n  ")

        XCTAssertNil(model.answer)
        XCTAssertFalse(model.isComplete)
    }

    func testSkippingQuestionStillCompletesBridge() {
        let prompt = FollowUpPrompt(id: "mood", prompt: "How did it feel?", inputStyle: .chips, options: ["uneasy"])
        let model = FollowUpViewModel(prompt: prompt)
        model.skip()
        XCTAssertTrue(model.isComplete)
        XCTAssertNil(model.answer)
    }
}
