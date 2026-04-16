import Foundation

struct AppEnvironment {
    let audioRecordingService: AudioRecordingServicing
    let speechTranscriptionService: SpeechTranscribing
    let followUpPromptService: FollowUpPromptServicing
    let dreamInterpretationService: DreamInterpretationServicing
    let patternSummaryService: PatternSummaryServicing
    let safeHarborService: SafeHarborServicing
    let privateWhisperService: PrivateWhisperServicing
    let ritualFlowCoordinator: RitualFlowCoordinator
    let previewFixtures: PreviewFixtures

    init(
        audioRecordingService: AudioRecordingServicing,
        speechTranscriptionService: SpeechTranscribing,
        followUpPromptService: FollowUpPromptServicing,
        dreamInterpretationService: DreamInterpretationServicing,
        patternSummaryService: PatternSummaryServicing,
        safeHarborService: SafeHarborServicing,
        privateWhisperService: PrivateWhisperServicing,
        ritualFlowCoordinator: RitualFlowCoordinator,
        previewFixtures: PreviewFixtures = .demo
    ) {
        self.audioRecordingService = audioRecordingService
        self.speechTranscriptionService = speechTranscriptionService
        self.followUpPromptService = followUpPromptService
        self.dreamInterpretationService = dreamInterpretationService
        self.patternSummaryService = patternSummaryService
        self.safeHarborService = safeHarborService
        self.privateWhisperService = privateWhisperService
        self.ritualFlowCoordinator = ritualFlowCoordinator
        self.previewFixtures = previewFixtures
    }

    func makeDreamCaptureViewModel() -> DreamCaptureViewModel {
        DreamCaptureViewModel(
            audioRecordingService: audioRecordingService,
            speechTranscriptionService: speechTranscriptionService
        )
    }

    static func live() -> AppEnvironment {
        let audioRecordingService = AudioRecordingService()
        let speechTranscriptionService = AppleSpeechTranscriptionService()
        let followUpPromptService = FollowUpPromptService()
        let dreamInterpretationService = DreamInterpretationService()
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService
        )

        return AppEnvironment(
            audioRecordingService: audioRecordingService,
            speechTranscriptionService: speechTranscriptionService,
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService,
            patternSummaryService: PatternSummaryService(),
            safeHarborService: SafeHarborService(),
            privateWhisperService: PrivateWhisperService(),
            ritualFlowCoordinator: coordinator,
            previewFixtures: .demo
        )
    }

    static func preview() -> AppEnvironment {
        let fixtures = PreviewFixtures.demo
        let audioRecordingService = PreviewAudioRecordingService()
        let speechTranscriptionService = PreviewSpeechTranscriptionService()
        let followUpPromptService = PreviewFollowUpPromptService(prompt: fixtures.followUpPrompt)
        let dreamInterpretationService = PreviewDreamInterpretationService(interpretation: fixtures.interpretation)
        let coordinator = RitualFlowCoordinator(
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService
        )

        return AppEnvironment(
            audioRecordingService: audioRecordingService,
            speechTranscriptionService: speechTranscriptionService,
            followUpPromptService: followUpPromptService,
            dreamInterpretationService: dreamInterpretationService,
            patternSummaryService: PreviewPatternSummaryService(summary: fixtures.patternSummary),
            safeHarborService: PreviewSafeHarborService(),
            privateWhisperService: PreviewPrivateWhisperService(),
            ritualFlowCoordinator: coordinator,
            previewFixtures: fixtures
        )
    }
}

private struct PreviewAudioRecordingService: AudioRecordingServicing {
    let isRecording = false

    func startRecording() {}

    func stopRecording() {}
}

private struct PreviewSpeechTranscriptionService: SpeechTranscribing {
    let authorizationStatus: SpeechTranscriptionAuthorizationStatus = .authorized
    let availability: SpeechTranscriptionAvailability = .available

    func refreshAuthorizationStatus() async -> SpeechTranscriptionAuthorizationStatus {
        authorizationStatus
    }

    func requestPermissions() async -> SpeechTranscriptionAuthorizationStatus {
        authorizationStatus
    }

    func startTranscribing(locale: Locale?) throws -> AsyncStream<SpeechTranscriptionEvent> {
        AsyncStream { continuation in
            continuation.yield(.started)
            continuation.yield(.transcriptUpdated(.init(text: "I was walking through a silver field.", isFinal: false)))
            continuation.yield(.finished(finalText: "I was walking through a silver field."))
            continuation.finish()
        }
    }

    func stopTranscribing() async {}

    func cancelTranscribing() async {}
}

private struct PreviewFollowUpPromptService: FollowUpPromptServicing {
    let prompt: FollowUpPrompt

    func prompts(for dream: DreamEntry) -> [FollowUpPrompt] {
        [prompt]
    }
}

private struct PreviewDreamInterpretationService: DreamInterpretationServicing {
    let interpretation: Interpretation

    func interpret(dream: DreamEntry) -> Interpretation {
        interpretation
    }
}

private struct PreviewPatternSummaryService: PatternSummaryServicing {
    let summary: PatternSummary

    func loadSummary() -> PatternSummary {
        summary
    }
}

private struct PreviewSafeHarborService: SafeHarborServicing {
    func loadItems() -> [SafeHarborItem] {
        [.breathing, .warmLight]
    }
}

private struct PreviewPrivateWhisperService: PrivateWhisperServicing {
    func loadWhispers() -> [PrivateWhisper] {
        [
            PrivateWhisper(
                featuredText: "A quieter pattern may be asking for your attention, not your urgency."
            )
        ]
    }
}
