import AVFoundation
import Foundation
import Speech

final class AppleSpeechTranscriptionService: SpeechTranscribing {
    private let locale: Locale?

    private var audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var currentContinuation: AsyncStream<SpeechTranscriptionEvent>.Continuation?

    private(set) var authorizationStatus: SpeechTranscriptionAuthorizationStatus = .notDetermined
    private(set) var availability: SpeechTranscriptionAvailability = .available

    init(locale: Locale? = nil) {
        self.locale = locale
    }

    func refreshAuthorizationStatus() async -> SpeechTranscriptionAuthorizationStatus {
        let speechStatus = mapAuthorizationStatus(SFSpeechRecognizer.authorizationStatus())
        let microphonePermission = AVAudioApplication.shared.recordPermission

        let mapped: SpeechTranscriptionAuthorizationStatus
        switch microphonePermission {
        case .granted:
            mapped = speechStatus
        case .denied:
            mapped = .microphoneDeniedEquivalent
        case .undetermined:
            mapped = speechStatus == .authorized ? .notDetermined : speechStatus
        @unknown default:
            mapped = .unsupported
        }

        authorizationStatus = mapped
        return mapped
    }

    func requestPermissions() async -> SpeechTranscriptionAuthorizationStatus {
        let microphoneAllowed = await requestMicrophonePermissionIfNeeded(promptOnly: true)
        guard microphoneAllowed else {
            authorizationStatus = .microphoneDeniedEquivalent
            return authorizationStatus
        }

        let speechStatus = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }

        let mapped = mapAuthorizationStatus(speechStatus)
        authorizationStatus = mapped
        return mapped
    }

    func startTranscribing(locale: Locale?) throws -> AsyncStream<SpeechTranscriptionEvent> {
        let resolvedLocale = locale ?? self.locale ?? Locale(identifier: "zh-CN")
        guard let recognizer = SFSpeechRecognizer(locale: resolvedLocale) else {
            availability = .localeUnsupported
            throw SpeechTranscriptionError.localeUnsupported
        }

        guard recognizer.isAvailable else {
            availability = .recognizerUnavailable
            throw SpeechTranscriptionError.speechRecognizerUnavailable
        }

        if recognitionTask != nil {
            throw SpeechTranscriptionError.alreadyRunning
        }

        availability = .available

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        recognitionRequest = request

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: [.duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw SpeechTranscriptionError.audioEngineFailure
        }

        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, _ in
            self?.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            inputNode.removeTap(onBus: 0)
            recognitionRequest = nil
            throw SpeechTranscriptionError.audioEngineFailure
        }

        return AsyncStream { continuation in
            self.currentContinuation = continuation
            continuation.yield(.started)

            self.recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
                guard let self else { return }

                if let result {
                    let transcription = result.bestTranscription.formattedString
                    continuation.yield(
                        .transcriptUpdated(
                            SpeechTranscriptionResult(text: transcription, isFinal: result.isFinal)
                        )
                    )

                    if result.isFinal {
                        continuation.yield(.finished(finalText: transcription))
                        Task { await self.stopTranscribing() }
                    }
                    return
                }

                if let error {
                    continuation.yield(.failed(.recognitionFailure(message: error.localizedDescription)))
                    Task { await self.cancelTranscribing() }
                }
            }

            continuation.onTermination = { [weak self] _ in
                Task { await self?.cancelTranscribing() }
            }
        }
    }

    func stopTranscribing() async {
        recognitionRequest?.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.finish()
        recognitionTask = nil
        recognitionRequest = nil
        currentContinuation?.yield(.stopped)
        currentContinuation?.finish()
        currentContinuation = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    func cancelTranscribing() async {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest = nil
        currentContinuation?.yield(.stopped)
        currentContinuation?.finish()
        currentContinuation = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    private func requestMicrophonePermissionIfNeeded(promptOnly: Bool) async -> Bool {
        switch AVAudioApplication.shared.recordPermission {
        case .granted:
            return true
        case .denied:
            return false
        case .undetermined:
            if promptOnly == false {
                return false
            }
            return await withCheckedContinuation { continuation in
                AVAudioApplication.requestRecordPermission { allowed in
                    continuation.resume(returning: allowed)
                }
            }
        @unknown default:
            return false
        }
    }

    private func mapAuthorizationStatus(_ status: SFSpeechRecognizerAuthorizationStatus) -> SpeechTranscriptionAuthorizationStatus {
        switch status {
        case .notDetermined:
            .notDetermined
        case .authorized:
            .authorized
        case .denied:
            .denied
        case .restricted:
            .restricted
        @unknown default:
            .unsupported
        }
    }
}

private extension SpeechTranscriptionAuthorizationStatus {
    static let microphoneDeniedEquivalent: SpeechTranscriptionAuthorizationStatus = .denied
}
