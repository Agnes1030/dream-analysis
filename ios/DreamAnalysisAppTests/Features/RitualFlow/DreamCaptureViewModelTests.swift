import XCTest
@testable import DreamAnalysisApp

final class DreamCaptureViewModelTests: XCTestCase {
    func testStartCaptureStartsAudioRecordingAndTranscription() {
        let audioService = TestAudioRecordingService()
        let transcriptionService = TestSpeechTranscriptionService()
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )

        model.startCapture()

        XCTAssertTrue(audioService.startRecordingCalled)
        XCTAssertTrue(transcriptionService.startTranscribingCalled)
        XCTAssertTrue(model.isRecording)
    }

    func testStopCaptureStopsAudioRecordingAndTranscription() {
        let audioService = TestAudioRecordingService(isRecording: true)
        let transcriptionService = TestSpeechTranscriptionService()
        let model = DreamCaptureViewModel(
            audioRecordingService: audioService,
            speechTranscriptionService: transcriptionService
        )
        model.startCapture()

        model.stopCapture()

        XCTAssertTrue(audioService.stopRecordingCalled)
        XCTAssertTrue(transcriptionService.stopTranscribingCalled)
        XCTAssertFalse(model.isRecording)
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
    private(set) var startTranscribingCalled = false
    private(set) var stopTranscribingCalled = false

    func startTranscribing() {
        startTranscribingCalled = true
    }

    func stopTranscribing() {
        stopTranscribingCalled = true
    }
}
