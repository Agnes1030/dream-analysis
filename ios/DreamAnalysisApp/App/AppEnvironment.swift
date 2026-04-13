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

    static func live() -> AppEnvironment {
        let coordinator = RitualFlowCoordinator()
        coordinator.finishResult()

        return AppEnvironment(
            audioRecordingService: AudioRecordingService(),
            speechTranscriptionService: SpeechTranscriptionService(),
            followUpPromptService: FollowUpPromptService(),
            dreamInterpretationService: DreamInterpretationService(),
            patternSummaryService: PatternSummaryService(),
            safeHarborService: SafeHarborService(),
            privateWhisperService: PrivateWhisperService(),
            ritualFlowCoordinator: coordinator,
            previewFixtures: .demo
        )
    }

    static func preview() -> AppEnvironment {
        let fixtures = PreviewFixtures.demo

        return AppEnvironment(
            audioRecordingService: PreviewAudioRecordingService(),
            speechTranscriptionService: PreviewSpeechTranscriptionService(),
            followUpPromptService: PreviewFollowUpPromptService(prompt: fixtures.followUpPrompt),
            dreamInterpretationService: PreviewDreamInterpretationService(interpretation: fixtures.interpretation),
            patternSummaryService: PreviewPatternSummaryService(),
            safeHarborService: PreviewSafeHarborService(),
            privateWhisperService: PreviewPrivateWhisperService(),
            ritualFlowCoordinator: RitualFlowCoordinator(),
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
    func startTranscribing() {}

    func stopTranscribing() {}
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
    func loadSummary() -> PatternSummary {
        .earlyUse
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
