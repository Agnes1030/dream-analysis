import XCTest
@testable import DreamAnalysisApp

final class AppRootViewModelTests: XCTestCase {
    func testDefaultTabIsHome() {
        let state = AppRootState()
        XCTAssertEqual(state.selectedTab, .home)
    }

    func testAllTabsProvideNonEmptyShellMetadata() {
        for tab in AppTab.allCases {
            XCTAssertFalse(tab.title.isEmpty)
            XCTAssertFalse(tab.systemImageName.isEmpty)
        }
    }

    func testSheetBindingCancelsFlowWhenDismissed() {
        let followUpPromptService = AppRootTestFollowUpPromptService()
        let dreamInterpretationService = AppRootTestDreamInterpretationService()
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService
        )
        let environment = AppEnvironment(
            audioRecordingService: AppRootTestAudioRecordingService(),
            speechTranscriptionService: AppRootTestSpeechTranscriptionService(),
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService,
            patternSummaryService: AppRootTestPatternSummaryService(),
            safeHarborService: AppRootTestSafeHarborService(),
            privateWhisperService: AppRootTestPrivateWhisperService(),
            ritualFlowCoordinator: coordinator,
            previewFixtures: .demo
        )
        let state = AppRootState()

        coordinator.startCapture()
        coordinator.continueFromCapture(DreamEntry(rawTranscript: "Lantern path"))

        let binding = state.ritualFlowBinding(for: environment)
        binding.wrappedValue = false

        XCTAssertFalse(coordinator.isPresentingFlow)
        XCTAssertEqual(coordinator.step, .capture)
        XCTAssertNil(coordinator.dream)
        XCTAssertNil(coordinator.followUpPrompt)
        XCTAssertNil(coordinator.interpretation)
    }

    func testRitualFlowRouteReturnsCaptureWhenCoordinatorIsOnCaptureStep() {
        let environment = makeEnvironment()
        let state = AppRootState()

        environment.ritualFlowCoordinator.startCapture()

        XCTAssertEqual(state.ritualFlowRoute(for: environment), .capture)
    }

    func testRitualFlowRouteReturnsFollowUpWhenCoordinatorHasPrompt() {
        let environment = makeEnvironment()
        let state = AppRootState()
        let dream = DreamEntry(rawTranscript: "Lantern path")

        environment.ritualFlowCoordinator.startCapture()
        environment.ritualFlowCoordinator.continueFromCapture(dream)

        XCTAssertEqual(
            state.ritualFlowRoute(for: environment),
            .followUp(AppRootTestFollowUpPromptService.prompt)
        )
    }

    func testRitualFlowRouteReturnsAnalyzingWhenCoordinatorIsProcessingInterpretation() {
        let environment = makeEnvironment(prompts: [])
        let state = AppRootState()
        let dream = DreamEntry(rawTranscript: "Lantern path")

        environment.ritualFlowCoordinator.startCapture()
        environment.ritualFlowCoordinator.continueFromCapture(dream)

        XCTAssertEqual(state.ritualFlowRoute(for: environment), .analyzing)
    }

    func testRitualFlowRouteReturnsResultWhenCoordinatorHasInterpretation() {
        let environment = makeEnvironment(prompts: [])
        let state = AppRootState()
        let dream = DreamEntry(rawTranscript: "Lantern path")

        environment.ritualFlowCoordinator.startCapture()
        environment.ritualFlowCoordinator.continueFromCapture(dream)
        environment.ritualFlowCoordinator.finishAnalyzing()

        XCTAssertEqual(
            state.ritualFlowRoute(for: environment),
            .result(dream, AppRootTestDreamInterpretationService.interpretation)
        )
    }

    func testResultCompletionActionFinishesCoordinatorFlow() {
        let environment = makeEnvironment(prompts: [])
        let state = AppRootState()

        environment.ritualFlowCoordinator.startCapture()
        environment.ritualFlowCoordinator.continueFromCapture(DreamEntry(rawTranscript: "Lantern path"))
        environment.ritualFlowCoordinator.finishAnalyzing()

        state.resultCompletionAction(for: environment)()

        XCTAssertFalse(environment.ritualFlowCoordinator.isPresentingFlow)
        XCTAssertEqual(environment.ritualFlowCoordinator.step, .capture)
        XCTAssertNil(environment.ritualFlowCoordinator.dream)
        XCTAssertNil(environment.ritualFlowCoordinator.followUpPrompt)
        XCTAssertNil(environment.ritualFlowCoordinator.interpretation)
    }

    private func makeEnvironment(prompts: [FollowUpPrompt] = [AppRootTestFollowUpPromptService.prompt]) -> AppEnvironment {
        let followUpPromptService = AppRootTestFollowUpPromptService(prompts: prompts)
        let dreamInterpretationService = AppRootTestDreamInterpretationService()
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService
        )

        return AppEnvironment(
            audioRecordingService: AppRootTestAudioRecordingService(),
            speechTranscriptionService: AppRootTestSpeechTranscriptionService(),
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService,
            patternSummaryService: AppRootTestPatternSummaryService(),
            safeHarborService: AppRootTestSafeHarborService(),
            privateWhisperService: AppRootTestPrivateWhisperService(),
            ritualFlowCoordinator: coordinator,
            previewFixtures: .demo
        )
    }
}

private struct AppRootTestAudioRecordingService: AudioRecordingServicing {
    let isRecording = false

    func startRecording() {}
    func stopRecording() {}
}

private struct AppRootTestSpeechTranscriptionService: SpeechTranscribing {
    let authorizationStatus: SpeechTranscriptionAuthorizationStatus = .authorized
    let availability: SpeechTranscriptionAvailability = .available

    func refreshAuthorizationStatus() async -> SpeechTranscriptionAuthorizationStatus { authorizationStatus }
    func requestPermissions() async -> SpeechTranscriptionAuthorizationStatus { authorizationStatus }
    func startTranscribing(locale: Locale?) throws -> AsyncStream<SpeechTranscriptionEvent> { AsyncStream { $0.finish() } }
    func stopTranscribing() async {}
    func cancelTranscribing() async {}
}

private struct AppRootTestFollowUpPromptService: FollowUpPromptServicing {
    static let prompt = FollowUpPrompt(
        id: "feeling",
        prompt: "What feeling stayed with you?",
        inputStyle: .chips,
        options: ["Curious"]
    )

    let prompts: [FollowUpPrompt]

    init(prompts: [FollowUpPrompt] = [Self.prompt]) {
        self.prompts = prompts
    }

    func prompts(for dream: DreamEntry) -> [FollowUpPrompt] {
        prompts
    }
}

private struct AppRootTestDreamInterpretationService: DreamInterpretationServicing {
    static let interpretation = Interpretation(
        coreInsight: "Insight",
        symbolicSummary: "Summary",
        personalReflection: "Reflection"
    )

    func interpret(dream: DreamEntry) -> Interpretation {
        Self.interpretation
    }
}

private struct AppRootTestPatternSummaryService: PatternSummaryServicing {
    func loadSummary() -> PatternSummary { .earlyUse }
}

private struct AppRootTestSafeHarborService: SafeHarborServicing {
    func loadItems() -> [SafeHarborItem] { [.breathing] }
}

private struct AppRootTestPrivateWhisperService: PrivateWhisperServicing {
    func loadWhispers() -> [PrivateWhisper] { [PrivateWhisper(featuredText: "Quiet")] }
}
