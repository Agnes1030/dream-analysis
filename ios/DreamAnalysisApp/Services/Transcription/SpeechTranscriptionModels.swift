import Foundation

enum SpeechTranscriptionAuthorizationStatus: Equatable, Sendable {
    case notDetermined
    case authorized
    case denied
    case restricted
    case unsupported
}

enum SpeechTranscriptionAvailability: Equatable, Sendable {
    case available
    case recognizerUnavailable
    case localeUnsupported
    case deviceUnavailable
    case audioSessionUnavailable
}

struct SpeechTranscriptionResult: Equatable, Sendable {
    let text: String
    let isFinal: Bool

    init(text: String, isFinal: Bool) {
        self.text = text
        self.isFinal = isFinal
    }
}

enum SpeechTranscriptionError: Error, Equatable, Sendable {
    case microphonePermissionDenied
    case speechPermissionDenied
    case speechRecognizerUnavailable
    case localeUnsupported
    case audioEngineFailure
    case recognitionFailure(message: String)
    case interrupted
    case alreadyRunning
    case notRunning
    case unknown
}

enum SpeechTranscriptionEvent: Equatable, Sendable {
    case started
    case transcriptUpdated(SpeechTranscriptionResult)
    case finished(finalText: String)
    case failed(SpeechTranscriptionError)
    case stopped
}

enum DreamCaptureState: Equatable, Sendable {
    case idle
    case requestingPermissions
    case listening
    case processing
    case completed
    case failed(String)
}
