import Observation

@Observable
final class InterpretationResultViewModel {
    let dream: DreamEntry
    let interpretation: Interpretation
    var didShowSavedConfirmation = false

    init(dream: DreamEntry, interpretation: Interpretation) {
        self.dream = dream
        self.interpretation = interpretation
    }

    func save() {
        dream.interpretationSummary = interpretation.coreInsight
        dream.reflectionSnippet = interpretation.personalReflection
        dream.isArchived = true
        didShowSavedConfirmation = true
    }

    func complete() {}
}
