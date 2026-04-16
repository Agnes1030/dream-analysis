import Foundation

protocol SpeechTranscribing {
    var authorizationStatus: SpeechTranscriptionAuthorizationStatus { get }
    var availability: SpeechTranscriptionAvailability { get }

    func refreshAuthorizationStatus() async -> SpeechTranscriptionAuthorizationStatus
    func requestPermissions() async -> SpeechTranscriptionAuthorizationStatus
    func startTranscribing(locale: Locale?) throws -> AsyncStream<SpeechTranscriptionEvent>
    func stopTranscribing() async
    func cancelTranscribing() async
}

final class SpeechTranscriptionService: SpeechTranscribing {
    private(set) var authorizationStatus: SpeechTranscriptionAuthorizationStatus = .notDetermined
    private(set) var availability: SpeechTranscriptionAvailability = .available

    func refreshAuthorizationStatus() async -> SpeechTranscriptionAuthorizationStatus {
        authorizationStatus
    }

    func requestPermissions() async -> SpeechTranscriptionAuthorizationStatus {
        authorizationStatus = .authorized
        return authorizationStatus
    }

    func startTranscribing(locale: Locale?) throws -> AsyncStream<SpeechTranscriptionEvent> {
        AsyncStream { continuation in
            continuation.finish()
        }
    }

    func stopTranscribing() async {
    }

    func cancelTranscribing() async {
    }
}
