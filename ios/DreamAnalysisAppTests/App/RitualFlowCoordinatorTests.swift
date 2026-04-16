import XCTest
@testable import DreamAnalysisApp

final class RitualFlowCoordinatorTests: XCTestCase {
    func testStartCapturePresentsCaptureStep() {
        let coordinator = RitualFlowCoordinator()

        coordinator.startCapture()

        XCTAssertTrue(coordinator.isPresentingFlow)
        XCTAssertEqual(coordinator.step, .capture)
        XCTAssertNil(coordinator.dream)
        XCTAssertNil(coordinator.followUpPrompt)
        XCTAssertNil(coordinator.interpretation)
    }

    func testContinueFromCaptureWithPromptAdvancesToFollowUp() {
        let prompt = FollowUpPrompt(
            id: "feeling",
            prompt: "What feeling stayed with you?",
            inputStyle: .chips,
            options: ["Curious"]
        )
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: StubFollowUpPromptService(prompts: [prompt]),
            dreamInterpretationService: StubDreamInterpretationService()
        )
        let dream = DreamEntry(rawTranscript: "I was walking through a garden.")

        coordinator.startCapture()
        coordinator.continueFromCapture(dream)

        XCTAssertEqual(coordinator.step, .followUp)
        XCTAssertTrue(coordinator.isPresentingFlow)
        XCTAssertEqual(coordinator.dream?.rawTranscript, dream.rawTranscript)
        XCTAssertEqual(coordinator.followUpPrompt, prompt)
        XCTAssertNil(coordinator.interpretation)
    }

    func testContinueFromCaptureWithoutPromptAdvancesToAnalyzingThenResult() {
        let interpretation = Interpretation(
            coreInsight: "Insight",
            symbolicSummary: "Summary",
            personalReflection: "Reflection"
        )
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: StubFollowUpPromptService(prompts: []),
            dreamInterpretationService: StubDreamInterpretationService(interpretation: interpretation)
        )
        let dream = DreamEntry(rawTranscript: "Ocean tide")

        coordinator.startCapture()
        coordinator.continueFromCapture(dream)

        XCTAssertEqual(coordinator.step, .analyzing)
        XCTAssertEqual(coordinator.dream?.rawTranscript, dream.rawTranscript)
        XCTAssertNil(coordinator.followUpPrompt)
        XCTAssertNil(coordinator.interpretation)

        coordinator.finishAnalyzing()

        XCTAssertEqual(coordinator.step, .result)
        XCTAssertEqual(coordinator.interpretation, interpretation)
    }

    func testContinueFromFollowUpStoresAnswerThenAdvancesToAnalyzingAndResult() {
        let prompt = FollowUpPrompt(
            id: "feeling",
            prompt: "What feeling stayed with you?",
            inputStyle: .chips,
            options: ["Curious"]
        )
        let interpretation = Interpretation(
            coreInsight: "Insight",
            symbolicSummary: "Summary",
            personalReflection: "Reflection"
        )
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: StubFollowUpPromptService(prompts: [prompt]),
            dreamInterpretationService: StubDreamInterpretationService(interpretation: interpretation)
        )
        let dream = DreamEntry(rawTranscript: "Ocean tide")

        coordinator.startCapture()
        coordinator.continueFromCapture(dream)
        coordinator.continueFromFollowUp(answer: "Curious")

        XCTAssertEqual(coordinator.step, .analyzing)
        XCTAssertEqual(coordinator.dream?.followUpAnswer, "Curious")
        XCTAssertEqual(coordinator.followUpPrompt, prompt)
        XCTAssertNil(coordinator.interpretation)

        coordinator.finishAnalyzing()

        XCTAssertEqual(coordinator.step, .result)
        XCTAssertEqual(coordinator.interpretation, interpretation)
    }

    func testCancelFlowDismissesAndResetsStateFromAnyStep() {
        let prompt = FollowUpPrompt(
            id: "feeling",
            prompt: "What feeling stayed with you?",
            inputStyle: .chips,
            options: ["Curious"]
        )
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: StubFollowUpPromptService(prompts: [prompt]),
            dreamInterpretationService: StubDreamInterpretationService()
        )

        coordinator.startCapture()
        coordinator.continueFromCapture(DreamEntry(rawTranscript: "A lantern"))

        coordinator.cancelFlow()

        XCTAssertFalse(coordinator.isPresentingFlow)
        XCTAssertEqual(coordinator.step, .capture)
        XCTAssertNil(coordinator.dream)
        XCTAssertNil(coordinator.followUpPrompt)
        XCTAssertNil(coordinator.interpretation)
    }

    func testFinishResultDismissesFlowAndResetsState() {
        let prompt = FollowUpPrompt(
            id: "feeling",
            prompt: "What feeling stayed with you?",
            inputStyle: .chips,
            options: ["Curious"]
        )
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: StubFollowUpPromptService(prompts: [prompt]),
            dreamInterpretationService: StubDreamInterpretationService()
        )

        coordinator.startCapture()
        coordinator.continueFromCapture(DreamEntry(rawTranscript: "A lantern"))
        coordinator.finishResult()

        XCTAssertFalse(coordinator.isPresentingFlow)
        XCTAssertEqual(coordinator.step, .capture)
        XCTAssertNil(coordinator.dream)
        XCTAssertNil(coordinator.followUpPrompt)
        XCTAssertNil(coordinator.interpretation)
    }

    func testPreviewEnvironmentUsesPreviewServiceStubsInsteadOfLiveServices() {
        let environment = AppEnvironment.preview()

        XCTAssertNotEqual(String(describing: type(of: environment.audioRecordingService)), String(describing: AudioRecordingService.self))
        XCTAssertNotEqual(String(describing: type(of: environment.speechTranscriptionService)), String(describing: SpeechTranscriptionService.self))
        XCTAssertNotEqual(String(describing: type(of: environment.followUpPromptService)), String(describing: FollowUpPromptService.self))
        XCTAssertNotEqual(String(describing: type(of: environment.dreamInterpretationService)), String(describing: DreamInterpretationService.self))
        XCTAssertNotEqual(String(describing: type(of: environment.patternSummaryService)), String(describing: PatternSummaryService.self))
        XCTAssertNotEqual(String(describing: type(of: environment.safeHarborService)), String(describing: SafeHarborService.self))
        XCTAssertNotEqual(String(describing: type(of: environment.privateWhisperService)), String(describing: PrivateWhisperService.self))
    }
}

private struct StubFollowUpPromptService: FollowUpPromptServicing {
    let prompts: [FollowUpPrompt]

    func prompts(for dream: DreamEntry) -> [FollowUpPrompt] {
        prompts
    }
}

private struct StubDreamInterpretationService: DreamInterpretationServicing {
    let interpretation: Interpretation

    init(interpretation: Interpretation = Interpretation()) {
        self.interpretation = interpretation
    }

    func interpret(dream: DreamEntry) -> Interpretation {
        interpretation
    }
}
