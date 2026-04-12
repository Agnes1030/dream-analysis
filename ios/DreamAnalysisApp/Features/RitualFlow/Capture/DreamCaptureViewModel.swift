import Observation

@Observable
final class DreamCaptureViewModel {
    var transcript = ""
    private(set) var isRecording = false

    private let audioRecordingService: AudioRecordingServicing
    private let speechTranscriptionService: SpeechTranscribing

    init(
        audioRecordingService: AudioRecordingServicing = AudioRecordingService(),
        speechTranscriptionService: SpeechTranscribing = SpeechTranscriptionService()
    ) {
        self.audioRecordingService = audioRecordingService
        self.speechTranscriptionService = speechTranscriptionService
        self.isRecording = audioRecordingService.isRecording
    }

    func startCapture() {
        audioRecordingService.startRecording()
        speechTranscriptionService.startTranscribing()
        isRecording = audioRecordingService.isRecording
    }

    func stopCapture() {
        audioRecordingService.stopRecording()
        speechTranscriptionService.stopTranscribing()
        isRecording = audioRecordingService.isRecording
    }

    func finishCapture() -> DreamEntry {
        DreamEntry(rawTranscript: transcript)
    }
}
