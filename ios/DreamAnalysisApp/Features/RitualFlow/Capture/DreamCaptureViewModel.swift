import Observation
import Foundation

@Observable
final class DreamCaptureViewModel {
    var transcript = ""
    private(set) var isRecording = false
    private(set) var captureState: DreamCaptureState = .idle
    private(set) var authorizationStatus: SpeechTranscriptionAuthorizationStatus = .notDetermined
    private(set) var availability: SpeechTranscriptionAvailability = .available
    private(set) var errorMessage: String?

    private let audioRecordingService: AudioRecordingServicing
    private let speechTranscriptionService: SpeechTranscribing

    init(
        audioRecordingService: AudioRecordingServicing = AudioRecordingService(),
        speechTranscriptionService: SpeechTranscribing = SpeechTranscriptionService()
    ) {
        self.audioRecordingService = audioRecordingService
        self.speechTranscriptionService = speechTranscriptionService
        self.isRecording = audioRecordingService.isRecording
        self.authorizationStatus = speechTranscriptionService.authorizationStatus
        self.availability = speechTranscriptionService.availability
    }

    func startCapture() async {
        errorMessage = nil
        captureState = .requestingPermissions

        authorizationStatus = await speechTranscriptionService.refreshAuthorizationStatus()
        if authorizationStatus == .notDetermined {
            authorizationStatus = await speechTranscriptionService.requestPermissions()
        }

        guard authorizationStatus == .authorized else {
            let message = "Speech recognition permission is needed before you can speak your dream."
            captureState = .failed(message)
            errorMessage = message
            isRecording = false
            return
        }

        availability = speechTranscriptionService.availability
        guard availability == .available else {
            let message = "Speech recognition is not available right now. You can still type your dream below."
            captureState = .failed(message)
            errorMessage = message
            isRecording = false
            return
        }

        audioRecordingService.startRecording()
        isRecording = audioRecordingService.isRecording
        captureState = .listening

        do {
            let stream = try speechTranscriptionService.startTranscribing(locale: nil)
            for await event in stream {
                await handle(event: event)
            }
        } catch {
            let message = "Something interrupted speech recognition. You can try again or type your dream below."
            captureState = .failed(message)
            errorMessage = message
            isRecording = false
        }
    }

    func stopCapture() async {
        audioRecordingService.stopRecording()
        await speechTranscriptionService.stopTranscribing()
        isRecording = audioRecordingService.isRecording
        if captureState != .completed {
            captureState = .processing
        }
    }

    func finishCapture() -> DreamEntry {
        DreamEntry(rawTranscript: transcript)
    }

    @MainActor
    private func handle(event: SpeechTranscriptionEvent) {
        switch event {
        case .started:
            captureState = .listening
            isRecording = audioRecordingService.isRecording
        case let .transcriptUpdated(result):
            transcript = result.text
            captureState = result.isFinal ? .processing : .listening
        case let .finished(finalText):
            transcript = finalText
            captureState = .completed
            isRecording = false
        case let .failed(error):
            let message = message(for: error)
            captureState = .failed(message)
            errorMessage = message
            isRecording = false
        case .stopped:
            isRecording = false
            if captureState != .completed {
                captureState = .processing
            }
        }
    }

    private func message(for error: SpeechTranscriptionError) -> String {
        switch error {
        case .microphonePermissionDenied, .speechPermissionDenied:
            return "Speech recognition permission is needed before you can speak your dream."
        case .speechRecognizerUnavailable, .localeUnsupported, .audioEngineFailure, .recognitionFailure, .interrupted, .alreadyRunning, .notRunning, .unknown:
            return "Something interrupted speech recognition. You can try again or type your dream below."
        }
    }
}
