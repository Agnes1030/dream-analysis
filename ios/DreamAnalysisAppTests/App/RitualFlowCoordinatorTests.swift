import XCTest
@testable import DreamAnalysisApp

final class RitualFlowCoordinatorTests: XCTestCase {
    func testResultCompletesBackToStableShell() {
        let coordinator = RitualFlowCoordinator()
        coordinator.finishResult()
        XCTAssertFalse(coordinator.isPresentingFlow)
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
