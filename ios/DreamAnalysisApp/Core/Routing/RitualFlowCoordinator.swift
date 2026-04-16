import Foundation
import Observation

@Observable
final class RitualFlowCoordinator {
    enum Step: Equatable {
        case capture
        case followUp
        case analyzing
        case result
    }

    var isPresentingFlow = false
    var step: Step = .capture
    var dream: DreamEntry?
    var followUpPrompt: FollowUpPrompt?
    var interpretation: Interpretation?

    private let followUpPromptService: FollowUpPromptServicing
    private let dreamInterpretationService: DreamInterpretationServicing

    init(
        followUpPromptService: FollowUpPromptServicing = FollowUpPromptService(),
        dreamInterpretationService: DreamInterpretationServicing = DreamInterpretationService()
    ) {
        self.followUpPromptService = followUpPromptService
        self.dreamInterpretationService = dreamInterpretationService
    }

    func startCapture() {
        resetFlowState()
        isPresentingFlow = true
    }

    func continueFromCapture(_ dream: DreamEntry) {
        self.dream = dream

        if let prompt = followUpPromptService.prompts(for: dream).first {
            followUpPrompt = prompt
            interpretation = nil
            step = .followUp
        } else {
            followUpPrompt = nil
            interpretation = nil
            step = .analyzing
        }
    }

    func continueFromFollowUp(answer: String?) {
        dream?.followUpAnswer = answer
        guard dream != nil else { return }

        interpretation = nil
        step = .analyzing
    }

    func finishAnalyzing() {
        guard let dream else { return }
        interpretation = dreamInterpretationService.interpret(dream: dream)
        step = .result
    }

    func cancelFlow() {
        isPresentingFlow = false
        resetFlowState()
    }

    func finishResult() {
        isPresentingFlow = false
        resetFlowState()
    }

    private func resetFlowState() {
        step = .capture
        dream = nil
        followUpPrompt = nil
        interpretation = nil
    }
}
