import Observation

@Observable
final class PatternsViewModel {
    let patternSummary: PatternSummary

    init(patternSummary: PatternSummary) {
        self.patternSummary = patternSummary
    }

    var shouldExplainGrowth: Bool {
        patternSummary.stage == .early
    }
}
