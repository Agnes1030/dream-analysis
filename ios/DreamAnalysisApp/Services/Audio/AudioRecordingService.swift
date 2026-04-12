import Foundation

protocol AudioRecordingServicing {
    var isRecording: Bool { get }

    func startRecording()
    func stopRecording()
}

final class AudioRecordingService: AudioRecordingServicing {
    private(set) var isRecording = false

    func startRecording() {
        isRecording = true
    }

    func stopRecording() {
        isRecording = false
    }
}
