import XCTest
@testable import DreamAnalysisApp

final class DreamCaptureViewModelTests: XCTestCase {
    func testStartCaptureStartsAudioRecordingAndTranscription() async {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService()
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        await model.startCapture()

        XCTAssertTrue(audioService.startRecordingCalled)
        XCTAssertTrue(transcriptionService.startTranscribingCalled)
        XCTAssertTrue(model.isRecording)
    }

    func testStopCaptureStopsAudioRecordingAndTranscription() async {
        let audioService = TestAudioRecordingService(isRecording: true)
        let transcriptionService = TestSpeechTranscriptionService()
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )
        await model.startCapture()

        await model.stopCapture()

        XCTAssertTrue(audioService.stopRecordingCalled)
        XCTAssertTrue(transcriptionService.stopTranscribingCalled)
        XCTAssertFalse(model.isRecording)
    }

    func testStartCaptureRequestsPermissionsWhenNotDetermined() async {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService(
            authorizationStatus: .notDetermined,
            availability: .available
        )
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        await model.startCapture()

        XCTAssertTrue(transcriptionService.requestPermissionsCalled)
    }

    func testDeniedPermissionsPreventCaptureAndSurfaceMessage() async {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService(
            authorizationStatus: .denied,
            availability: .available
        )
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        await model.startCapture()

        XCTAssertFalse(model.isRecording)
        XCTAssertEqual(model.captureState, DreamCaptureState.failed("Speech recognition permission is needed before you can speak your dream."))
        XCTAssertEqual(model.errorMessage, "Speech recognition permission is needed before you can speak your dream.")
        XCTAssertFalse(audioService.startRecordingCalled)
    }

    func testRecognizerUnavailablePreventsCaptureAndSurfacesMessage() async {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService(
            authorizationStatus: .authorized,
            availability: .recognizerUnavailable
        )
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        await model.startCapture()

        XCTAssertFalse(model.isRecording)
        XCTAssertEqual(model.captureState, DreamCaptureState.failed("Speech recognition is not available right now. You can still type your dream below."))
        XCTAssertEqual(model.errorMessage, "Speech recognition is not available right now. You can still type your dream below.")
        XCTAssertFalse(audioService.startRecordingCalled)
    }

    func testTranscriptionEventsUpdateTranscriptAndFinalizeText() async {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService(
            authorizationStatus: .authorized,
            availability: .available,
            events: [
                .started,
                .transcriptUpdated(.init(text: "I was", isFinal: false)),
                .transcriptUpdated(.init(text: "I was walking home", isFinal: true)),
                .finished(finalText: "I was walking home")
            ]
        )
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        await model.startCapture()

        XCTAssertEqual(model.transcript, "I was walking home")
        XCTAssertEqual(model.captureState, DreamCaptureState.completed)
        XCTAssertFalse(model.isRecording)
    }

    func testServiceFailureSurfacesUserFacingError() async {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService(
            authorizationStatus: .authorized,
            availability: .available,
            events: [.failed(.recognitionFailure(message: "network"))]
        )
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        await model.startCapture()

        XCTAssertEqual(model.captureState, DreamCaptureState.failed("Something interrupted speech recognition. You can try again or type your dream below."))
        XCTAssertEqual(model.errorMessage, "Something interrupted speech recognition. You can try again or type your dream below.")
    }

    func testFinishingCaptureCreatesDraftDream() {
        let model = DreamCaptureViewModel()
        model.transcript = "I was running through a forest"

        let dream = model.finishCapture()

        XCTAssertEqual(dream.rawTranscript, "I was running through a forest")
    }
}

private final class TestAudioRecordingService: AudioRecordingServicing {
    private(set) var isRecording: Bool
    private(set) var startRecordingCalled = false
    private(set) var stopRecordingCalled = false

    init(isRecording: Bool = false) {
        self.isRecording = isRecording
    }

    func startRecording() {
        startRecordingCalled = true
        isRecording = true
    }

    func stopRecording() {
        stopRecordingCalled = true
        isRecording = false
    }
}

private final class TestSpeechTranscriptionService: SpeechTranscribing {
    private(set) var authorizationStatus: SpeechTranscriptionAuthorizationStatus
    private(set) var availability: SpeechTranscriptionAvailability
    private(set) var requestPermissionsCalled = false
    private(set) var startTranscribingCalled = false
    private(set) var stopTranscribingCalled = false
    private(set) var cancelTranscribingCalled = false
    private let events: [SpeechTranscriptionEvent]

    init(
        authorizationStatus: SpeechTranscriptionAuthorizationStatus = .authorized,
        availability: SpeechTranscriptionAvailability = .available,
        events: [SpeechTranscriptionEvent] = []
    ) {
        self.authorizationStatus = authorizationStatus
        self.availability = availability
        self.events = events
    }

    func refreshAuthorizationStatus() async -> SpeechTranscriptionAuthorizationStatus {
        authorizationStatus
    }

    func requestPermissions() async -> SpeechTranscriptionAuthorizationStatus {
        requestPermissionsCalled = true
        if authorizationStatus == .notDetermined {
            authorizationStatus = .authorized
        }
        return authorizationStatus
    }

    func startTranscribing(locale: Locale?) throws -> AsyncStream<SpeechTranscriptionEvent> {
        startTranscribingCalled = true
        return AsyncStream { continuation in
            for event in events {
                continuation.yield(event)
            }
            continuation.finish()
        }
    }

    func stopTranscribing() async {
        stopTranscribingCalled = true
    }

    func cancelTranscribing() async {
        cancelTranscribingCalled = true
    }
}
